// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// An optional container for grouping together multiple form field widgets
/// (e.g. [TextField] widgets).
///
/// Each individual form field should be wrapped in a [FFormField] widget, with
/// the [FForm] widget as a common ancestor of all of those. Call methods on
/// [FFormState] to save, reset, or validate each [FFormField] that is a
/// descendant of this [FForm]. To obtain the [FFormState], you may use [FForm.of]
/// with a context whose ancestor is the [FForm], or pass a [GlobalKey] to the
/// [FForm] constructor and call [GlobalKey.currentState].
///
/// {@tool dartpad --template=stateful_widget_scaffold}
/// This example shows a [FForm] with one [TextFormField] to enter an email
/// address and an [ElevatedButton] to submit the form. A [GlobalKey] is used here
/// to identify the [FForm] and validate input.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)
///
/// ```dart
/// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
///
/// @override
/// Widget build(BuildContext context) {
///   return Form(
///     key: _formKey,
///     child: Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: <Widget>[
///         TextFormField(
///           decoration: const InputDecoration(
///             hintText: 'Enter your email',
///           ),
///           validator: (String? value) {
///             if (value == null || value.isEmpty) {
///               return 'Please enter some text';
///             }
///             return null;
///           },
///         ),
///         Padding(
///           padding: const EdgeInsets.symmetric(vertical: 16.0),
///           child: ElevatedButton(
///             onPressed: () {
///               // Validate will return true if the form is valid, or false if
///               // the form is invalid.
///               if (_formKey.currentState!.validate()) {
///                 // Process data.
///               }
///             },
///             child: const Text('Submit'),
///           ),
///         ),
///       ],
///     ),
///   );
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [GlobalKey], a key that is unique across the entire app.
///  * [FFormField], a single form field widget that maintains the current state.
///  * [TextFormField], a convenience widget that wraps a [TextField] widget in a [FFormField].
class FForm extends StatefulWidget {
  /// Creates a container for form fields.
  ///
  /// The [child] argument must not be null.
  const FForm({
    Key key,
    @required
        this.child,
    @Deprecated(
      'Use autovalidateMode parameter which provides more specific '
      'behavior related to auto validation. '
      'This feature was deprecated after v1.19.0.',
    )
        this.autovalidate = false,
    this.onWillPop,
    this.onChanged,
    AutovalidateMode autovalidateMode,
  })  : assert(child != null),
        assert(autovalidate != null),
        assert(
          autovalidate == false ||
              autovalidate == true && autovalidateMode == null,
          'autovalidate and autovalidateMode should not be used together.',
        ),
        autovalidateMode = autovalidateMode ??
            (autovalidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled),
        super(key: key);

  /// Returns the closest [FFormState] which encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// FormState form = Form.of(context);
  /// form.save();
  /// ```
  static FFormState of(BuildContext context) {
    final _FormScope scope =
        context.dependOnInheritedWidgetOfExactType<_FormScope>();
    return scope?._formState;
  }

  /// The widget below this widget in the tree.
  ///
  /// This is the root of the widget hierarchy that contains this form.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Enables the form to veto attempts by the user to dismiss the [ModalRoute]
  /// that contains the form.
  ///
  /// If the callback returns a Future that resolves to false, the form's route
  /// will not be popped.
  ///
  /// See also:
  ///
  ///  * [WillPopScope], another widget that provides a way to intercept the
  ///    back button.
  final WillPopCallback onWillPop;

  /// Called when one of the form fields changes.
  ///
  /// In addition to this callback being invoked, all the form fields themselves
  /// will rebuild.
  final VoidCallback onChanged;

  /// Used to enable/disable form fields auto validation and update their error
  /// text.
  ///
  /// {@macro flutter.widgets.FormField.autovalidateMode}
  final AutovalidateMode autovalidateMode;

  /// Used to enable/disable form fields auto validation and update their error
  /// text.
  @Deprecated(
    'Use autovalidateMode parameter which provides more specific '
    'behavior related to auto validation. '
    'This feature was deprecated after v1.19.0.',
  )
  final bool autovalidate;

  @override
  FFormState createState() => FFormState();
}

/// State associated with a [FForm] widget.
///
/// A [FFormState] object can be used to [save], [reset], and [validate] every
/// [FFormField] that is a descendant of the associated [FForm].
///
/// Typically obtained via [FForm.of].
class FFormState extends State<FForm> {
  int _generation = 0;
  bool _hasInteractedByUser = false;
  final Set<FFormFieldState<dynamic>> _fields = <FFormFieldState<dynamic>>{};

  // Called when a form field has changed. This will cause all form fields
  // to rebuild, useful if form fields have interdependencies.
  void _fieldDidChange() {
    widget.onChanged?.call();

    _hasInteractedByUser = _fields
        .any((FFormFieldState<dynamic> field) => field._hasInteractedByUser);
    _forceRebuild();
  }

  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

  void _register(FFormFieldState<dynamic> field) {
    _fields.add(field);
  }

  void _unregister(FFormFieldState<dynamic> field) {
    _fields.remove(field);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.autovalidateMode) {
      case AutovalidateMode.always:
        _validate();
        break;
      case AutovalidateMode.onUserInteraction:
        if (_hasInteractedByUser) {
          _validate();
        }
        break;
      case AutovalidateMode.disabled:
        break;
    }

    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: _FormScope(
        formState: this,
        generation: _generation,
        child: widget.child,
      ),
    );
  }

  /// Saves every [FFormField] that is a descendant of this [FForm].
  void save() {
    for (final FFormFieldState<dynamic> field in _fields) field.save();
  }

  /// Resets every [FFormField] that is a descendant of this [FForm] back to its
  /// [FFormField.initialValue].
  ///
  /// The [FForm.onChanged] callback will be called.
  ///
  /// If the form's [FForm.autovalidateMode] property is [AutovalidateMode.always],
  /// the fields will all be revalidated after being reset.
  void reset() {
    for (final FFormFieldState<dynamic> field in _fields) field.reset();
    _hasInteractedByUser = false;
    _fieldDidChange();
  }

  /// Validates every [FFormField] that is a descendant of this [FForm], and
  /// returns true if there are no errors.
  ///
  /// The form will rebuild to report the results.
  bool validate() {
    _hasInteractedByUser = true;
    _forceRebuild();
    return _validate();
  }

  bool _validate() {
    bool hasError = false;
    for (final FFormFieldState<dynamic> field in _fields)
      hasError = !field.validate() || hasError;
    return !hasError;
  }
}

class _FormScope extends InheritedWidget {
  const _FormScope({
    Key key,
    @required Widget child,
    @required FFormState formState,
    @required int generation,
  })  : _formState = formState,
        _generation = generation,
        super(key: key, child: child);

  final FFormState _formState;

  /// Incremented every time a form field has changed. This lets us know when
  /// to rebuild the form.
  final int _generation;

  /// The [FForm] associated with this widget.
  FForm get form => _formState.widget;

  @override
  bool updateShouldNotify(_FormScope old) => _generation != old._generation;
}

/// Signature for validating a form field.
///
/// Returns an error string to display if the input is invalid, or null
/// otherwise.
///
/// Used by [FFormField.validator].
typedef FFormFieldValidator<T> = FTextFieldStatus Function(T value);

/// Signature for being notified when a form field changes value.
///
/// Used by [FFormField.onSaved].
typedef FFormFieldSetter<T> = void Function(T newValue);

/// Signature for building the widget representing the form field.
///
/// Used by [FFormField.builder].
typedef FormFieldBuilder<T> = Widget Function(FFormFieldState<T> field);

/// A single form field.
///
/// This widget maintains the current state of the form field, so that updates
/// and validation errors are visually reflected in the Views.
///
/// When used inside a [FForm], you can use methods on [FFormState] to query or
/// manipulate the form data as a whole. For example, calling [FFormState.save]
/// will invoke each [FFormField]'s [onSaved] callback in turn.
///
/// Use a [GlobalKey] with [FFormField] if you want to retrieve its current
/// state, for example if you want one form field to depend on another.
///
/// A [FForm] ancestor is not required. The [FForm] simply makes it easier to
/// save, reset, or validate multiple fields at once. To use without a [FForm],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
///
/// See also:
///
///  * [FForm], which is the widget that aggregates the form fields.
///  * [TextField], which is a commonly used form field for entering text.
class FFormField<T> extends StatefulWidget {
  /// Creates a single form field.
  ///
  /// The [builder] argument must not be null.
  const FFormField({
    Key key,
    @required
        this.builder,
    this.onSaved,
    this.validator,
    this.initialValue,
    @Deprecated(
      'Use autovalidateMode parameter which provides more specific '
      'behavior related to auto validation. '
      'This feature was deprecated after v1.19.0.',
    )
        this.autovalidate = false,
    this.enabled = true,
    AutovalidateMode autovalidateMode,
  })  : assert(builder != null),
        assert(
          autovalidate == false ||
              autovalidate == true && autovalidateMode == null,
          'autovalidate and autovalidateMode should not be used together.',
        ),
        autovalidateMode = autovalidateMode ??
            (autovalidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled),
        super(key: key);

  /// An optional method to call with the final value when the form is saved via
  /// [FFormState.save].
  final FFormFieldSetter<T> onSaved;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  ///
  /// The returned value is exposed by the [FFormFieldState.errorText] property.
  /// The [TextFormField] uses this to override the [InputDecoration.errorText]
  /// value.
  ///
  /// Alternating between error and normal state can cause the height of the
  /// [TextFormField] to change if no other subtext decoration is set on the
  /// field. To create a field whose height is fixed regardless of whether or
  /// not an error is displayed, either wrap the  [TextFormField] in a fixed
  /// height parent like [SizedBox], or set the [InputDecoration.helperText]
  /// parameter to a space.
  final FFormFieldValidator<T> validator;

  /// Function that returns the widget representing this form field. It is
  /// passed the form field state as input, containing the current value and
  /// validation state of this field.
  final FormFieldBuilder<T> builder;

  /// An optional value to initialize the form field to, or null otherwise.
  final T initialValue;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidateMode] is not [AutovalidateMode.disabled],
  /// the field will be auto validated. Likewise, if this field is false, the widget
  /// will not be validated regardless of [autovalidateMode].
  final bool enabled;

  /// Used to enable/disable this form field auto validation and update its
  /// error text.
  ///
  /// {@template flutter.widgets.FormField.autovalidateMode}
  /// If [AutovalidateMode.onUserInteraction] this form field will only
  /// auto-validate after its content changes, if [AutovalidateMode.always] it
  /// will auto validate even without user interaction and
  /// if [AutovalidateMode.disabled] the auto validation will be disabled.
  ///
  /// Defaults to [AutovalidateMode.disabled] if `autovalidate` is false which
  /// means no auto validation will occur. If `autovalidate` is true then this
  /// is set to [AutovalidateMode.always] for backward compatibility.
  /// {@endtemplate}
  final AutovalidateMode autovalidateMode;

  /// Used to enable/disable auto validation and update their error
  /// text.
  @Deprecated(
    'Use autovalidateMode parameter which provides more specific '
    'behavior related to auto validation. '
    'This feature was deprecated after v1.19.0.',
  )
  final bool autovalidate;

  @override
  FFormFieldState<T> createState() => FFormFieldState<T>();
}

/// The current state of a [FFormField]. Passed to the [FormFieldBuilder] method
/// for use in constructing the form field's widget.
class FFormFieldState<T> extends State<FFormField<T>> {
  T _value;
  // String _errorText;
  // String _successText;
  String _statusText;
  TFStatus _status;
  bool _hasInteractedByUser = false;

  /// The current value of the form field.
  T get value => _value;

  /// The current validation error returned by the [FFormField.validator]
  /// callback, or null if no errors have been triggered. This only updates when
  /// [validate] is called.
  // String get errorText => _errorText;
  // String get successText => _successText;
  String get statusText => _statusText;
  TFStatus get status {
    if (_status == null) {
      return TFStatus.normal;
    }
    return _status;
  }

  /// True if this field has any validation errors.
  // bool get hasError => _errorText != null;
  // bool get hasSuccess => _successText != null;
  bool get hasStatus => _statusText != null;

  /// True if the current value is valid.
  ///
  /// This will not set [errorText] or [hasError] and it will not update
  /// error display.
  ///
  /// See also:
  ///
  ///  * [validate], which may update [errorText] and [hasError].
  bool get isValid => widget.validator?.call(_value) == null;

  /// Calls the [FFormField]'s onSaved method with the current value.
  void save() {
    widget.onSaved?.call(value);
  }

  /// Resets the field to its initial value.
  void reset() {
    setState(() {
      _value = widget.initialValue;
      _hasInteractedByUser = false;
      // _errorText = null;
      // _successText = null;
      _statusText = null;
    });
    FForm.of(context)?._fieldDidChange();
  }

  /// Calls [FFormField.validator] to set the [errorText]. Returns true if there
  /// were no errors.
  ///
  /// See also:
  ///
  ///  * [isValid], which passively gets the validity without setting
  ///    [errorText] or [hasError].
  bool validate() {
    setState(() {
      _validate();
    });
    return !hasStatus;
  }

  void _validate() {
    if (widget.validator != null) {
      _statusText = widget.validator(_value).message;
      _status = widget.validator(_value).status;
      // if (widget.validator(_value).status == Status.success) {
      //   _successText = widget.validator(_value).message;
      //   _errorText = null;
      // } else if (widget.validator(_value).status == Status.error) {
      //   _errorText = widget.validator(_value).message;
      //   _successText = null;
      // } else {
      //   _errorText = null;
      //   _successText = null;
      // }
    }
  }

  /// Updates this field's state to the new value. Useful for responding to
  /// child widget changes, e.g. [Slider]'s [Slider.onChanged] argument.
  ///
  /// Triggers the [FForm.onChanged] callback and, if [FForm.autovalidateMode] is
  /// [AutovalidateMode.always] or [AutovalidateMode.onUserInteraction],
  /// revalidates all the fields of the form.
  void didChange(T value) {
    setState(() {
      _value = value;
      _hasInteractedByUser = true;
    });
    FForm.of(context)?._fieldDidChange();
  }

  /// Sets the value associated with this form field.
  ///
  /// This method should only be called by subclasses that need to update
  /// the form field value due to state changes identified during the widget
  /// build phase, when calling `setState` is prohibited. In all other cases,
  /// the value should be set by a call to [didChange], which ensures that
  /// `setState` is called.
  @protected
  void setValue(T value) {
    _value = value;
  }

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void deactivate() {
    FForm.of(context)?._unregister(this);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enabled) {
      switch (widget.autovalidateMode) {
        case AutovalidateMode.always:
          _validate();
          break;
        case AutovalidateMode.onUserInteraction:
          if (_hasInteractedByUser) {
            _validate();
          }
          break;
        case AutovalidateMode.disabled:
          break;
      }
    }
    FForm.of(context)?._register(this);
    return widget.builder(this);
  }
}

// /// Used to configure the auto validation of [FormField] and [FForm] widgets.
// enum AutovalidateMode {
//   /// No auto validation will occur.
//   disabled,

//   /// Used to auto-validate [FForm] and [FormField] even without user interaction.
//   always,

//   /// Used to auto-validate [FForm] and [FormField] only after each user
//   /// interaction.
//   onUserInteraction,
// }

class FTextFieldStatus {
  final TFStatus status;
  final String message;
  FTextFieldStatus({this.message, this.status = TFStatus.normal});
}

enum TFStatus {
  normal,
  error,
  success,
}
