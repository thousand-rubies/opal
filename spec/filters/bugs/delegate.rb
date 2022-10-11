# NOTE: run bin/format-filters after changing this file
opal_filter "Delegate" do
  fails "Delegator#!= is delegated in general" # Exception: Maximum call stack size exceeded
  fails "Delegator#== is delegated in general" # Exception: Maximum call stack size exceeded
  fails "Delegator#method raises a NameError if method is no longer valid because object has changed" # Expected NameError but no exception was raised ("foo" was returned)
  fails "Delegator#method returns a method that respond_to_missing?" # NameError: undefined method `pub_too' for class `DelegateSpecs::Simple'
  fails "Delegator#methods includes instance methods of the Delegator class" # Expected ["singleton_method",  "pub",  "respond_to_missing?",  "method_missing",  "priv",  "prot",  "to_json",  "guard",  "guard_not",  "with_feature",  "without_feature",  "new_fd",  "new_io",  "should",  "should_not",  "version_is",  "ruby_version_is",  "suppress_warning",  "suppress_keyword_warning",  "should_receive",  "should_not_receive",  "stub!",  "mock",  "mock_int",  "mock_numeric",  "evaluate",  "before",  "after",  "describe",  "it",  "it_should_behave_like",  "context",  "specify",  "it_behaves_like",  "ruby_bug",  "conflicts_with",  "big_endian",  "little_endian",  "platform_is",  "platform_is_not",  "quarantine!",  "not_supported_on",  "as_superuser",  "as_user",  "argf",  "argv",  "new_datetime",  "with_timezone",  "fixture",  "flunk",  "cp",  "mkdir_p",  "rm_r",  "touch",  "mock_to_path",  "nan_value",  "infinity_value",  "bignum_value",  "max_long",  "min_long",  "fixnum_max",  "fixnum_min",  "ruby_exe_options",  "resolve_ruby_exe",  "ruby_exe",  "ruby_cmd",  "opal_filter",  "opal_unsupported_filter",  "frozen_error_class",  "pack_format",  "DelegateClass",  "module_specs_public_method_on_object",  "module_specs_private_method_on_object",  "module_specs_protected_method_on_object",  "module_specs_private_method_on_object_for_kernel_public",  "module_specs_public_method_on_object_for_kernel_protected",  "module_specs_public_method_on_object_for_kernel_private",  "unpack_format",  "be_close_to_matrix",  "example_instance_method_of_object",  "check_autoload",  "main_public_method",  "main_public_method2",  "main_private_method",  "main_private_method2",  "lang_send_rest_len",  "toplevel_define_other_method",  "some_toplevel_method",  "public_toplevel_method",  "defined_specs_method",  "defined_specs_receiver",  "expect",  "eq",  "pretty_print",  "pretty_print_cycle",  "pretty_print_instance_variables",  "pretty_print_inspect",  "=~",  "!~",  "===",  "<=>",  "method",  "methods",  "public_methods",  "Array",  "at_exit",  "caller",  "caller_locations",  "class",  "copy_instance_variables",  "copy_singleton_methods",  "clone",  "initialize_clone",  "define_singleton_method",  "dup",  "initialize_dup",  "enum_for",  "equal?",  "exit",  "extend",  "gets",  "hash",  "initialize_copy",  "inspect",  "instance_of?",  "instance_variable_defined?",  "instance_variable_get",  "instance_variable_set",  "remove_instance_variable",  "instance_variables",  "Integer",  "Float",  "Hash",  "is_a?",  "itself",  "lambda",  "load",  "loop",  "nil?",  "printf",  "proc",  "puts",  "p",  "print",  "readline",  "warn",  "raise",  "rand",  "respond_to?",  "require",  "require_relative",  "require_tree",  "singleton_class",  "sleep",  "srand",  "String",  "tap",  "to_proc",  "to_s",  "catch",  "throw",  "open",  "yield_self",  "fail",  "kind_of?",  "object_id",  "public_send",  "send",  "then",  "to_enum",  "format",  "sprintf",  "Complex",  "Rational",  "freeze",  "frozen?",  "taint",  "untaint",  "tainted?",  "private_methods",  "protected_methods",  "private_instance_methods",  "protected_instance_methods",  "eval",  "binding",  "Pathname",  "require_remote",  "pretty_inspect",  "pp",  "opal_parse",  "eval_js",  "BigDecimal",  "module_specs_public_method_on_kernel",  "module_specs_alias_on_kernel",  "__send__",  "__id__",  "==",  "!",  "initialize",  "eql?",  "!=",  "instance_eval",  "instance_exec",  "singleton_method_added",  "singleton_method_removed",  "singleton_method_undefined",  "__marshal__"] to include "extra"
  fails "Delegator#tap yield the delegator object" # Expected 0 == 1 to be truthy but was false
  fails "SimpleDelegator can be marshalled with its instance variables intact" # Exception: Cannot create property 'foo' on string 'hello'
  fails "SimpleDelegator can be marshalled" # Expected String == SimpleDelegator to be truthy but was false
end
