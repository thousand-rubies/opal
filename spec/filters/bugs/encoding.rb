# NOTE: run bin/format-filters after changing this file
opal_filter "Encoding" do
  fails "File.basename returns the basename with the same encoding as the original" # NameError: uninitialized constant Encoding::Windows_1250
  fails "Integer#to_s bignum returns a String in US-ASCII encoding when Encoding.default_internal is nil" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Integer#to_s bignum returns a String in US-ASCII encoding when Encoding.default_internal is not nil" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Integer#to_s bignum when given a base raises an ArgumentError if the base is less than 2 or higher than 36" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Integer#to_s bignum when given a base returns self converted to a String using the given base" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Integer#to_s bignum when given no base returns self converted to a String using base 10" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Integer#to_s fixnum returns a String in US-ASCII encoding when Encoding.default_internal is nil" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Integer#to_s fixnum returns a String in US-ASCII encoding when Encoding.default_internal is not nil" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Integer#to_s fixnum when given a base raises an ArgumentError if the base is less than 2 or higher than 36" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Integer#to_s fixnum when given a base returns self converted to a String in the given base" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Integer#to_s fixnum when no base given returns self converted to a String using base 10" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Kernel#sprintf returns a String in the same encoding as the format String if compatible" # NameError: uninitialized constant Encoding::KOI8_U
  fails "Marshal.dump when passed an IO calls binmode when it's defined" # ArgumentError: [Marshal.dump] wrong number of arguments(2 for 1)
  fails "Marshal.dump with a String dumps a String in another encoding" # Expected "\u0004\b\"\u000Fm\u0000ö\u0000h\u0000r\u0000e\u0000" to equal "\u0004\bI\"\u000Fm\u0000ö\u0000h\u0000r\u0000e\u0000\u0006:\rencoding\"\rUTF-16LE"
  fails "Marshal.dump with a String dumps a US-ASCII String" # Expected "\u0004\b\"\babc" to equal "\u0004\bI\"\babc\u0006:\u0006EF"
  fails "Marshal.dump with a String dumps a UTF-8 String" # Expected "\u0004\b\"\nmöhre" to equal "\u0004\bI\"\vmöhre\u0006:\u0006ET"
  fails "Marshal.dump with a String dumps multiple strings using symlinks for the :E (encoding) symbol" # Expected "\u0004\b[\a\"\u0000@\u0006" to equal "\u0004\b[\aI\"\u0000\u0006:\u0006EFI\"\u0000\u0006;\u0000T"
  fails "Marshal.load for a String loads a String in another encoding" # NameError: 'encoding' is not allowed as an instance variable name
  fails "Marshal.load for a String loads a US-ASCII String" # Expected #<Encoding:UTF-16LE> to be identical to #<Encoding:ASCII-8BIT (dummy)>
  fails "MatchData#post_match sets an empty result to the encoding of the source String" # NameError: uninitialized constant Encoding::ISO_8859_1
  fails "MatchData#post_match sets the encoding to the encoding of the source String" # NameError: uninitialized constant Encoding::EUC_JP
  fails "MatchData#pre_match sets an empty result to the encoding of the source String" # NameError: uninitialized constant Encoding::ISO_8859_1
  fails "MatchData#pre_match sets the encoding to the encoding of the source String" # NameError: uninitialized constant Encoding::EUC_JP
  fails "Predefined global $& sets the encoding to the encoding of the source String" # NameError: uninitialized constant Encoding::EUC_JP
  fails "Predefined global $' sets an empty result to the encoding of the source String" # NameError: uninitialized constant Encoding::ISO_8859_1
  fails "Predefined global $' sets the encoding to the encoding of the source String" # NameError: uninitialized constant Encoding::EUC_JP
  fails "Predefined global $+ sets the encoding to the encoding of the source String" # NameError: uninitialized constant Encoding::EUC_JP
  fails "Predefined global $` sets an empty result to the encoding of the source String" # NameError: uninitialized constant Encoding::ISO_8859_1
  fails "Predefined global $` sets the encoding to the encoding of the source String" # NameError: uninitialized constant Encoding::EUC_JP
  fails "Predefined globals $1..N sets the encoding to the encoding of the source String" # NameError: uninitialized constant Encoding::EUC_JP
  fails "Regexp#match with [string, position] when given a negative position raises an ArgumentError for an invalid encoding" # NoMethodError: undefined method `pack' for [150]:Array
  fails "Regexp#match with [string, position] when given a positive position raises an ArgumentError for an invalid encoding" # NoMethodError: undefined method `pack' for [150]:Array
  fails "Ruby String interpolation raises an Encoding::CompatibilityError if the Encodings are not compatible" # Expected Encoding::CompatibilityError but no exception was raised ("あ ÿ" was returned)
  fails "Source files encoded in UTF-16 BE with a BOM are invalid because they contain an invalid UTF-8 sequence before the encoding comment" # NoMethodError: undefined method `tmp' for #<MSpecEnv:0x7a11e>
  fails "Source files encoded in UTF-16 BE without a BOM are parsed as empty because they contain a NUL byte before the encoding comment" # NoMethodError: undefined method `tmp' for #<MSpecEnv:0x7a11e>
  fails "Source files encoded in UTF-16 LE with a BOM are invalid because they contain an invalid UTF-8 sequence before the encoding comment" # NoMethodError: undefined method `tmp' for #<MSpecEnv:0x7a11e>
  fails "Source files encoded in UTF-16 LE without a BOM are parsed because empty as they contain a NUL byte before the encoding comment" # NoMethodError: undefined method `tmp' for #<MSpecEnv:0x7a11e>
  fails "Source files encoded in UTF-8 with a BOM can be parsed" # NoMethodError: undefined method `tmp' for #<MSpecEnv:0x7a11e>
  fails "Source files encoded in UTF-8 without a BOM can be parsed" # NoMethodError: undefined method `tmp' for #<MSpecEnv:0x7a11e>
  fails "String#% output's encoding negotiates a compatible encoding if necessary" # Expected #<Encoding:UTF-16LE> to equal #<Encoding:ASCII-8BIT (dummy)>
  fails "String#* raises an ArgumentError if the length of the resulting string doesn't fit into a long" # RangeError: multiply count must not overflow maximum string size
  fails "String#[]= with String index encodes the String in an encoding compatible with the replacement" # NoMethodError: undefined method `pack' for [160]:Array
  fails "String#[]= with String index raises an Encoding::CompatibilityError if the replacement encoding is incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#[]= with String index replaces characters with a multibyte character" # NoMethodError: undefined method `[]=' for "ありgaとう":String
  fails "String#[]= with String index replaces multibyte characters with characters" # NoMethodError: undefined method `[]=' for "ありがとう":String
  fails "String#[]= with String index replaces multibyte characters with multibyte characters" # NoMethodError: undefined method `[]=' for "ありがとう":String
  fails "String#[]= with a Range index deletes a multibyte character" # NoMethodError: undefined method `[]=' for "ありとう":String
  fails "String#[]= with a Range index encodes the String in an encoding compatible with the replacement" # NoMethodError: undefined method `pack' for [160]:Array
  fails "String#[]= with a Range index inserts a multibyte character" # NoMethodError: undefined method `[]=' for "ありとう":String
  fails "String#[]= with a Range index raises an Encoding::CompatibilityError if the replacement encoding is incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#[]= with a Range index replaces characters with a multibyte character" # NoMethodError: undefined method `[]=' for "ありgaとう":String
  fails "String#[]= with a Range index replaces multibyte characters by negative indexes" # NoMethodError: undefined method `[]=' for "ありがとう":String
  fails "String#[]= with a Range index replaces multibyte characters with characters" # NoMethodError: undefined method `[]=' for "ありがとう":String
  fails "String#[]= with a Range index replaces multibyte characters with multibyte characters" # NoMethodError: undefined method `[]=' for "ありがとう":String
  fails "String#[]= with a Regexp index encodes the String in an encoding compatible with the replacement" # NoMethodError: undefined method `pack' for [160]:Array
  fails "String#[]= with a Regexp index raises an Encoding::CompatibilityError if the replacement encoding is incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#[]= with a Regexp index replaces characters with a multibyte character" # NoMethodError: undefined method `[]=' for "ありgaとう":String
  fails "String#[]= with a Regexp index replaces multibyte characters with characters" # NoMethodError: undefined method `[]=' for "ありがとう":String
  fails "String#[]= with a Regexp index replaces multibyte characters with multibyte characters" # NoMethodError: undefined method `[]=' for "ありがとう":String
  fails "String#ascii_only? returns false after appending non ASCII characters to an empty String" # NotImplementedError: String#<< not supported. Mutable String methods are not supported in Opal.
  fails "String#ascii_only? returns false when concatenating an ASCII and non-ASCII String" # NoMethodError: undefined method `concat' for "":String
  fails "String#ascii_only? returns false when replacing an ASCII String with a non-ASCII String" # NoMethodError: undefined method `replace' for "":String
  fails "String#b returns new string without modifying self" # NoMethodError: undefined method `b' for "こんちには":String
  fails "String#byteslice on on non ASCII strings returns byteslice of unicode strings" # Expected nil to equal "\u0081"
  fails "String#center with length, padding with width returns a String in the same encoding as the original" # NameError: uninitialized constant Encoding::IBM437
  fails "String#center with length, padding with width, pattern raises an Encoding::CompatibilityError if the encodings are incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#center with length, padding with width, pattern returns a String in the compatible encoding" # NameError: uninitialized constant Encoding::IBM437
  fails "String#chars returns a different character if the String is transcoded" # ArgumentError: unknown encoding name - iso-8859-15
  fails "String#chars returns characters in the same encoding as self" # ArgumentError: unknown encoding name - Shift_JIS
  fails "String#chars uses the String's encoding to determine what characters it contains" # Expected ["�", "�"] to equal ["𤭢"]
  fails "String#chars works if the String's contents is invalid for its encoding" # NoMethodError: undefined method `pack' for [164]:Array
  fails "String#chr returns a String in the same encoding as self" # Expected #<Encoding:UTF-16LE> to equal #<Encoding:ASCII-8BIT (dummy)>
  fails "String#chr returns a copy of self" # Expected "e" not to equal "e"
  fails "String#codepoints raises an ArgumentError if self's encoding is invalid and a block is given" # Expected true to be false
  fails "String#codepoints raises an ArgumentError when no block is given if self has an invalid encoding" # Expected true to be false
  fails "String#codepoints raises an ArgumentError when self has an invalid encoding and a method is called on the returned Enumerator" # Expected true to be false
  fails "String#codepoints round-trips to the original String using Integer#chr" # Expected "\u0013眑တ" to equal ""
  fails "String#each_char returns a different character if the String is transcoded" # ArgumentError: unknown encoding name - iso-8859-15
  fails "String#each_char returns characters in the same encoding as self" # ArgumentError: unknown encoding name - Shift_JIS
  fails "String#each_char uses the String's encoding to determine what characters it contains" # Expected ["�", "�"] to equal ["𤭢"]
  fails "String#each_char works if the String's contents is invalid for its encoding" # NoMethodError: undefined method `pack' for [164]:Array
  fails "String#each_codepoint raises an ArgumentError if self's encoding is invalid and a block is given" # Expected true to be false
  fails "String#each_codepoint raises an ArgumentError when self has an invalid encoding and a method is called on the returned Enumerator" # Expected true to be false
  fails "String#each_codepoint round-trips to the original String using Integer#chr" # NotImplementedError: String#<< not supported. Mutable String methods are not supported in Opal.
  fails "String#each_codepoint when no block is given returned Enumerator size should return the size of the string even when the string has an invalid encoding" # Expected true to be false
  fails "String#each_codepoint when no block is given returned Enumerator size should return the size of the string" # NoMethodError: undefined method `each_codepoint' for "hello":String
  fails "String#each_codepoint when no block is given returns an Enumerator even when self has an invalid encoding" # Expected true to be false
  fails "String#encode given the xml: :attr option replaces all instances of '&' with '&amp;'" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :attr option replaces all instances of '<' with '&lt;'" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :attr option replaces all instances of '>' with '&gt;'" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :attr option replaces all instances of '\"' with '&quot;'" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :attr option replaces undefined characters with their upper-case hexadecimal numeric character references" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :attr option surrounds the encoded text with double-quotes" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :text option does not replace '\"'" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :text option replaces all instances of '&' with '&amp;'" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :text option replaces all instances of '<' with '&lt;'" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :text option replaces all instances of '>' with '&gt;'" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode given the xml: :text option replaces undefined characters with their upper-case hexadecimal numeric character references" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode raises ArgumentError if the value of the :xml option is not :text or :attr" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed no options encodes an ascii substring of a binary string to UTF-8" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed no options raises an Encoding::ConverterNotFoundError when no conversion is possible" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed no options returns a copy for a ASCII-only String when Encoding.default_internal is nil" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed no options returns a copy when Encoding.default_internal is nil" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed no options transcodes a 7-bit String despite no generic converting being available" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed no options transcodes to Encoding.default_internal when set" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options calls #to_hash to convert the object" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options does not process transcoding options if not transcoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options normalizes newlines" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options raises an Encoding::ConverterNotFoundError when no conversion is possible despite 'invalid: :replace, undef: :replace'" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options replaces invalid characters when replacing Emacs-Mule encoded strings" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options replaces invalid encoding in source using a specified replacement even when a fallback is given" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options replaces invalid encoding in source using replace even when fallback is given as proc" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options replaces invalid encoding in source with a specified replacement" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options replaces invalid encoding in source with default replacement" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options replaces undefined encoding in destination using a fallback proc" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options replaces undefined encoding in destination with a specified replacement even if a fallback is given" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options replaces undefined encoding in destination with a specified replacement" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options replaces undefined encoding in destination with default replacement" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options returns a copy when Encoding.default_internal is nil" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed options transcodes to Encoding.default_internal when set" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to encoding accepts a String argument" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to encoding calls #to_str to convert the object to an Encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to encoding raises an Encoding::ConverterNotFoundError for an invalid encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to encoding raises an Encoding::ConverterNotFoundError when no conversion is possible" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to encoding returns a copy when passed the same encoding as the String" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to encoding round trips a String" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to encoding transcodes Japanese multibyte characters" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to encoding transcodes a 7-bit String despite no generic converting being available" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to encoding transcodes to the passed encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from calls #to_str to convert the from object to an Encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from returns a copy in the destination encoding when both encodings are the same" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from returns the transcoded string" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from transcodes between the encodings ignoring the String encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from, options calls #to_hash to convert the options object" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from, options calls #to_str to convert the from object to an encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from, options calls #to_str to convert the to object to an encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from, options replaces invalid characters in the destination encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from, options replaces undefined characters in the destination encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, from, options returns a copy when both encodings are the same" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, options calls #to_hash to convert the options object" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, options replaces invalid characters in the destination encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, options replaces undefined characters in the destination encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encode when passed to, options returns a copy when the destination encoding is the same as the String encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encoding for Strings with \\u escapes is not affected by both the default internal and external encoding being set at the same time" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encoding for Strings with \\u escapes is not affected by the default external encoding" # NameError: uninitialized constant Encoding::SHIFT_JIS
  fails "String#encoding for Strings with \\u escapes is not affected by the default internal encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encoding for Strings with \\u escapes returns US-ASCII if self is US-ASCII only" # Expected false to be true
  fails "String#encoding for Strings with \\u escapes returns the given encoding if #encode!has been called" # NameError: uninitialized constant Encoding::SHIFT_JIS
  fails "String#encoding for Strings with \\u escapes returns the given encoding if #force_encoding has been called" # NameError: uninitialized constant Encoding::SHIFT_JIS
  fails "String#encoding for Strings with \\x escapes is not affected by both the default internal and external encoding being set at the same time" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encoding for Strings with \\x escapes is not affected by the default external encoding" # NameError: uninitialized constant Encoding::SHIFT_JIS
  fails "String#encoding for Strings with \\x escapes is not affected by the default internal encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encoding for Strings with \\x escapes returns US-ASCII if self is US-ASCII only" # Expected false to be true
  fails "String#encoding for Strings with \\x escapes returns the given encoding if #encode!has been called" # NameError: uninitialized constant Encoding::SHIFT_JIS
  fails "String#encoding for Strings with \\x escapes returns the given encoding if #force_encoding has been called" # NameError: uninitialized constant Encoding::SHIFT_JIS
  fails "String#encoding for Strings with \\x escapes returns the source encoding when an escape creates a byte with the 8th bit set if the source encoding isn't US-ASCII" # NameError: uninitialized constant Encoding::ISO8859_9
  fails "String#encoding for US-ASCII Strings returns US-ASCII if self is US-ASCII only, despite the default encodings being different" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encoding for US-ASCII Strings returns US-ASCII if self is US-ASCII only, despite the default external encoding being different" # Expected #<Encoding:UTF-16LE> to equal #<Encoding:ASCII-8BIT (dummy)>
  fails "String#encoding for US-ASCII Strings returns US-ASCII if self is US-ASCII only, despite the default internal and external encodings being different" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encoding for US-ASCII Strings returns US-ASCII if self is US-ASCII only, despite the default internal encoding being different" # NoMethodError: undefined method `default_internal' for Encoding
  fails "String#encoding for US-ASCII Strings returns US-ASCII if self is US-ASCII" # Expected #<Encoding:UTF-16LE> to equal #<Encoding:ASCII-8BIT (dummy)>
  fails "String#encoding returns the given encoding if #encode!has been called" # NameError: uninitialized constant Encoding::SHIFT_JIS
  fails "String#encoding returns the given encoding if #force_encoding has been called" # NameError: uninitialized constant Encoding::SHIFT_JIS
  fails "String#force_encoding accepts a String as the name of an Encoding" # ArgumentError: unknown encoding name - shift_jis
  fails "String#force_encoding accepts an Encoding instance" # NameError: uninitialized constant Encoding::SHIFT_JIS
  fails "String#force_encoding calls #to_str to convert an object to an encoding name" # ArgumentError: unknown encoding name - #<MockObject:0xa7ea>
  fails "String#force_encoding does not transcode self" # Expected "蘒" not to equal "蘒"
  fails "String#force_encoding raises a TypeError if #to_str does not return a String" # ArgumentError: unknown encoding name - #<MockObject:0xa7d8>
  fails "String#force_encoding raises a TypeError if passed nil" # ArgumentError: unknown encoding name -
  fails "String#force_encoding sets the encoding even if the String contents are invalid in that encoding" # ArgumentError: unknown encoding name - euc-jp
  fails "String#index with Regexp raises an Encoding::CompatibilityError if the encodings are incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#index with String raises an Encoding::CompatibilityError if the encodings are incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#insert with index, other inserts a character into a multibyte encoded string" # NoMethodError: undefined method `insert' for "ありがとう":String
  fails "String#insert with index, other raises an Encoding::CompatibilityError if the encodings are incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#insert with index, other returns a String in the compatible encoding" # NoMethodError: undefined method `insert' for "":String
  fails "String#length returns the length of a string in different encodings" # NameError: uninitialized constant Encoding::UTF_32BE
  fails "String#length returns the length of the new self after encoding is changed" # Expected 4 to equal 12
  fails "String#ljust with length, padding with width returns a String in the same encoding as the original" # NameError: uninitialized constant Encoding::IBM437
  fails "String#ljust with length, padding with width, pattern raises an Encoding::CompatibilityError if the encodings are incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#ljust with length, padding with width, pattern returns a String in the compatible encoding" # NameError: uninitialized constant Encoding::IBM437
  fails "String#ord raises an ArgumentError if called on an empty String" # Expected ArgumentError but no exception was raised (NaN was returned)
  fails "String#rindex with Regexp raises an Encoding::CompatibilityError if the encodings are incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#rjust with length, padding with width returns a String in the same encoding as the original" # NameError: uninitialized constant Encoding::IBM437
  fails "String#rjust with length, padding with width, pattern raises an Encoding::CompatibilityError if the encodings are incompatible" # NameError: uninitialized constant Encoding::EUC_JP
  fails "String#rjust with length, padding with width, pattern returns a String in the compatible encoding" # NameError: uninitialized constant Encoding::IBM437
  fails "String#size returns the length of a string in different encodings" # NameError: uninitialized constant Encoding::UTF_32BE
  fails "String#size returns the length of the new self after encoding is changed" # Expected 4 to equal 12
  fails "String#split with String throws an ArgumentError if the pattern is not a valid string" # NotImplementedError: String#chop! not supported. Mutable String methods are not supported in Opal.
  fails "String#valid_encoding? returns false if a valid String had an invalid character appended to it" # NoMethodError: undefined method `pack' for [221]:Array
  fails "String#valid_encoding? returns false if self contains a character invalid in the associated encoding" # NoMethodError: undefined method `pack' for [128]:Array
  fails "String#valid_encoding? returns false if self is valid in one encoding, but invalid in the one it's tagged with" # Expected true to be false
  fails "String#valid_encoding? returns true for all encodings self is valid in" # Expected true to be false
  fails "String#valid_encoding? returns true if an invalid string is appended another invalid one but both make a valid string" # NoMethodError: undefined method `pack' for [208]:Array
  fails "The predefined global constant ARGV contains Strings encoded in locale Encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDERR has nil for the external encoding despite Encoding.default_external being changed" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDERR has nil for the external encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDERR has nil for the internal encoding despite Encoding.default_internal being changed" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDERR has nil for the internal encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDERR has the encodings set by #set_encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDIN has nil for the internal encoding despite Encoding.default_internal being changed" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDIN has nil for the internal encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDIN has the encodings set by #set_encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDIN has the same external encoding as Encoding.default_external when that encoding is changed" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDIN has the same external encoding as Encoding.default_external" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDIN retains the encoding set by #set_encoding when Encoding.default_external is changed" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDOUT has nil for the external encoding despite Encoding.default_external being changed" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDOUT has nil for the external encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDOUT has nil for the internal encoding despite Encoding.default_internal being changed" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDOUT has nil for the internal encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "The predefined global constant STDOUT has the encodings set by #set_encoding" # NoMethodError: undefined method `default_internal' for Encoding
  fails "Time#inspect returns a US-ASCII encoded string" # Expected #<Encoding:UTF-16LE> to be identical to #<Encoding:ASCII-8BIT (dummy)>
  fails "Time#to_s returns a US-ASCII encoded string" # Expected #<Encoding:UTF-16LE> to be identical to #<Encoding:ASCII-8BIT (dummy)>
end
