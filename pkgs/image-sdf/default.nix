{ self, fetchurl, fetchgit ? null, lib }:

{
  by-spec."ansi-regex"."^2.0.0" =
    self.by-version."ansi-regex"."2.0.0";
  by-version."ansi-regex"."2.0.0" = self.buildNodePackage {
    name = "ansi-regex-2.0.0";
    version = "2.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/ansi-regex/-/ansi-regex-2.0.0.tgz";
      name = "ansi-regex-2.0.0.tgz";
      sha1 = "c5061b6e0ef8a81775e50f5d66151bf6bf371107";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."ansi-styles"."^2.1.0" =
    self.by-version."ansi-styles"."2.1.0";
  by-version."ansi-styles"."2.1.0" = self.buildNodePackage {
    name = "ansi-styles-2.1.0";
    version = "2.1.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/ansi-styles/-/ansi-styles-2.1.0.tgz";
      name = "ansi-styles-2.1.0.tgz";
      sha1 = "990f747146927b559a932bf92959163d60c0d0e2";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."as-number"."^1.0.0" =
    self.by-version."as-number"."1.0.0";
  by-version."as-number"."1.0.0" = self.buildNodePackage {
    name = "as-number-1.0.0";
    version = "1.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/as-number/-/as-number-1.0.0.tgz";
      name = "as-number-1.0.0.tgz";
      sha1 = "acb27e34f8f9d8ab0da9e376f3b8959860f80a66";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."asn1"."0.1.11" =
    self.by-version."asn1"."0.1.11";
  by-version."asn1"."0.1.11" = self.buildNodePackage {
    name = "asn1-0.1.11";
    version = "0.1.11";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/asn1/-/asn1-0.1.11.tgz";
      name = "asn1-0.1.11.tgz";
      sha1 = "559be18376d08a4ec4dbe80877d27818639b2df7";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."assert-plus"."^0.1.5" =
    self.by-version."assert-plus"."0.1.5";
  by-version."assert-plus"."0.1.5" = self.buildNodePackage {
    name = "assert-plus-0.1.5";
    version = "0.1.5";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/assert-plus/-/assert-plus-0.1.5.tgz";
      name = "assert-plus-0.1.5.tgz";
      sha1 = "ee74009413002d84cec7219c6ac811812e723160";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."async"."^1.4.0" =
    self.by-version."async"."1.4.2";
  by-version."async"."1.4.2" = self.buildNodePackage {
    name = "async-1.4.2";
    version = "1.4.2";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/async/-/async-1.4.2.tgz";
      name = "async-1.4.2.tgz";
      sha1 = "6c9edcb11ced4f0dd2f2d40db0d49a109c088aab";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."aws-sign2"."~0.5.0" =
    self.by-version."aws-sign2"."0.5.0";
  by-version."aws-sign2"."0.5.0" = self.buildNodePackage {
    name = "aws-sign2-0.5.0";
    version = "0.5.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/aws-sign2/-/aws-sign2-0.5.0.tgz";
      name = "aws-sign2-0.5.0.tgz";
      sha1 = "c57103f7a17fc037f02d7c2e64b602ea223f7d63";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."bit-twiddle"."^1.0.0" =
    self.by-version."bit-twiddle"."1.0.2";
  by-version."bit-twiddle"."1.0.2" = self.buildNodePackage {
    name = "bit-twiddle-1.0.2";
    version = "1.0.2";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/bit-twiddle/-/bit-twiddle-1.0.2.tgz";
      name = "bit-twiddle-1.0.2.tgz";
      sha1 = "0c6c1fabe2b23d17173d9a61b7b7093eb9e1769e";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."bl"."~1.0.0" =
    self.by-version."bl"."1.0.0";
  by-version."bl"."1.0.0" = self.buildNodePackage {
    name = "bl-1.0.0";
    version = "1.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/bl/-/bl-1.0.0.tgz";
      name = "bl-1.0.0.tgz";
      sha1 = "ada9a8a89a6d7ac60862f7dec7db207873e0c3f5";
    };
    deps = {
      "readable-stream-2.0.2" = self.by-version."readable-stream"."2.0.2";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."bluebird"."^2.9.30" =
    self.by-version."bluebird"."2.10.0";
  by-version."bluebird"."2.10.0" = self.buildNodePackage {
    name = "bluebird-2.10.0";
    version = "2.10.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/bluebird/-/bluebird-2.10.0.tgz";
      name = "bluebird-2.10.0.tgz";
      sha1 = "701f502d2d236560df792c008fe1b3b3793c95f4";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."boom"."2.x.x" =
    self.by-version."boom"."2.8.0";
  by-version."boom"."2.8.0" = self.buildNodePackage {
    name = "boom-2.8.0";
    version = "2.8.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/boom/-/boom-2.8.0.tgz";
      name = "boom-2.8.0.tgz";
      sha1 = "317bdfd47018fe7dd79b0e9da73efe244119fdf1";
    };
    deps = {
      "hoek-2.16.2" = self.by-version."hoek"."2.16.2";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."boom"."^2.8.x" =
    self.by-version."boom"."2.8.0";
  by-spec."caseless"."~0.11.0" =
    self.by-version."caseless"."0.11.0";
  by-version."caseless"."0.11.0" = self.buildNodePackage {
    name = "caseless-0.11.0";
    version = "0.11.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/caseless/-/caseless-0.11.0.tgz";
      name = "caseless-0.11.0.tgz";
      sha1 = "715b96ea9841593cc33067923f5ec60ebda4f7d7";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."chalk"."^1.0.0" =
    self.by-version."chalk"."1.1.1";
  by-version."chalk"."1.1.1" = self.buildNodePackage {
    name = "chalk-1.1.1";
    version = "1.1.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/chalk/-/chalk-1.1.1.tgz";
      name = "chalk-1.1.1.tgz";
      sha1 = "509afb67066e7499f7eb3535c77445772ae2d019";
    };
    deps = {
      "ansi-styles-2.1.0" = self.by-version."ansi-styles"."2.1.0";
      "escape-string-regexp-1.0.3" = self.by-version."escape-string-regexp"."1.0.3";
      "has-ansi-2.0.0" = self.by-version."has-ansi"."2.0.0";
      "strip-ansi-3.0.0" = self.by-version."strip-ansi"."3.0.0";
      "supports-color-2.0.0" = self.by-version."supports-color"."2.0.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."clamp"."^1.0.1" =
    self.by-version."clamp"."1.0.1";
  by-version."clamp"."1.0.1" = self.buildNodePackage {
    name = "clamp-1.0.1";
    version = "1.0.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/clamp/-/clamp-1.0.1.tgz";
      name = "clamp-1.0.1.tgz";
      sha1 = "66a0e64011816e37196828fdc8c8c147312c8634";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."color-name"."1.0.x" =
    self.by-version."color-name"."1.0.0";
  by-version."color-name"."1.0.0" = self.buildNodePackage {
    name = "color-name-1.0.0";
    version = "1.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/color-name/-/color-name-1.0.0.tgz";
      name = "color-name-1.0.0.tgz";
      sha1 = "ce3579a4ef43b672bee4f37e8876332b5a36e6b5";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."color-string"."^0.2.1" =
    self.by-version."color-string"."0.2.4";
  by-version."color-string"."0.2.4" = self.buildNodePackage {
    name = "color-string-0.2.4";
    version = "0.2.4";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/color-string/-/color-string-0.2.4.tgz";
      name = "color-string-0.2.4.tgz";
      sha1 = "221ff64234f71aaa3e13bc8c7e8c95f3cdd8f81a";
    };
    deps = {
      "color-name-1.0.0" = self.by-version."color-name"."1.0.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."combined-stream"."^1.0.5" =
    self.by-version."combined-stream"."1.0.5";
  by-version."combined-stream"."1.0.5" = self.buildNodePackage {
    name = "combined-stream-1.0.5";
    version = "1.0.5";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/combined-stream/-/combined-stream-1.0.5.tgz";
      name = "combined-stream-1.0.5.tgz";
      sha1 = "938370a57b4a51dea2c77c15d5c5fdf895164009";
    };
    deps = {
      "delayed-stream-1.0.0" = self.by-version."delayed-stream"."1.0.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."combined-stream"."~1.0.1" =
    self.by-version."combined-stream"."1.0.5";
  by-spec."commander"."^2.8.1" =
    self.by-version."commander"."2.8.1";
  by-version."commander"."2.8.1" = self.buildNodePackage {
    name = "commander-2.8.1";
    version = "2.8.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/commander/-/commander-2.8.1.tgz";
      name = "commander-2.8.1.tgz";
      sha1 = "06be367febfda0c330aa1e2a072d3dc9762425d4";
    };
    deps = {
      "graceful-readlink-1.0.1" = self.by-version."graceful-readlink"."1.0.1";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."contentstream"."^1.0.0" =
    self.by-version."contentstream"."1.0.0";
  by-version."contentstream"."1.0.0" = self.buildNodePackage {
    name = "contentstream-1.0.0";
    version = "1.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/contentstream/-/contentstream-1.0.0.tgz";
      name = "contentstream-1.0.0.tgz";
      sha1 = "0bdcfa46da30464a86ce8fa7ece565410dc6f9a5";
    };
    deps = {
      "readable-stream-1.0.33" = self.by-version."readable-stream"."1.0.33";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."core-util-is"."~1.0.0" =
    self.by-version."core-util-is"."1.0.1";
  by-version."core-util-is"."1.0.1" = self.buildNodePackage {
    name = "core-util-is-1.0.1";
    version = "1.0.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/core-util-is/-/core-util-is-1.0.1.tgz";
      name = "core-util-is-1.0.1.tgz";
      sha1 = "6b07085aef9a3ccac6ee53bf9d3df0c1521a5538";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."cryptiles"."2.x.x" =
    self.by-version."cryptiles"."2.0.5";
  by-version."cryptiles"."2.0.5" = self.buildNodePackage {
    name = "cryptiles-2.0.5";
    version = "2.0.5";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/cryptiles/-/cryptiles-2.0.5.tgz";
      name = "cryptiles-2.0.5.tgz";
      sha1 = "3bdfecdc608147c1c67202fa291e7dca59eaa3b8";
    };
    deps = {
      "boom-2.8.0" = self.by-version."boom"."2.8.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."ctype"."0.5.3" =
    self.by-version."ctype"."0.5.3";
  by-version."ctype"."0.5.3" = self.buildNodePackage {
    name = "ctype-0.5.3";
    version = "0.5.3";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/ctype/-/ctype-0.5.3.tgz";
      name = "ctype-0.5.3.tgz";
      sha1 = "82c18c2461f74114ef16c135224ad0b9144ca12f";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."cwise-compiler"."^0.1.0" =
    self.by-version."cwise-compiler"."0.1.0";
  by-version."cwise-compiler"."0.1.0" = self.buildNodePackage {
    name = "cwise-compiler-0.1.0";
    version = "0.1.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/cwise-compiler/-/cwise-compiler-0.1.0.tgz";
      name = "cwise-compiler-0.1.0.tgz";
      sha1 = "899e5c1981b56041ab2921864b034fe0d591b71a";
    };
    deps = {
      "uniq-0.0.2" = self.by-version."uniq"."0.0.2";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."data-uri-to-buffer"."0.0.3" =
    self.by-version."data-uri-to-buffer"."0.0.3";
  by-version."data-uri-to-buffer"."0.0.3" = self.buildNodePackage {
    name = "data-uri-to-buffer-0.0.3";
    version = "0.0.3";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/data-uri-to-buffer/-/data-uri-to-buffer-0.0.3.tgz";
      name = "data-uri-to-buffer-0.0.3.tgz";
      sha1 = "18ae979a6a0ca994b0625853916d2662bbae0b1a";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."delayed-stream"."~1.0.0" =
    self.by-version."delayed-stream"."1.0.0";
  by-version."delayed-stream"."1.0.0" = self.buildNodePackage {
    name = "delayed-stream-1.0.0";
    version = "1.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/delayed-stream/-/delayed-stream-1.0.0.tgz";
      name = "delayed-stream-1.0.0.tgz";
      sha1 = "df3ae199acadfb7d440aaae0b29e2272b24ec619";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."dup"."^1.0.0" =
    self.by-version."dup"."1.0.0";
  by-version."dup"."1.0.0" = self.buildNodePackage {
    name = "dup-1.0.0";
    version = "1.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/dup/-/dup-1.0.0.tgz";
      name = "dup-1.0.0.tgz";
      sha1 = "51fc5ac685f8196469df0b905e934b20af5b4029";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."escape-string-regexp"."^1.0.2" =
    self.by-version."escape-string-regexp"."1.0.3";
  by-version."escape-string-regexp"."1.0.3" = self.buildNodePackage {
    name = "escape-string-regexp-1.0.3";
    version = "1.0.3";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-1.0.3.tgz";
      name = "escape-string-regexp-1.0.3.tgz";
      sha1 = "9e2d8b25bc2555c3336723750e03f099c2735bb5";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."extend"."~3.0.0" =
    self.by-version."extend"."3.0.0";
  by-version."extend"."3.0.0" = self.buildNodePackage {
    name = "extend-3.0.0";
    version = "3.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/extend/-/extend-3.0.0.tgz";
      name = "extend-3.0.0.tgz";
      sha1 = "5a474353b9f3353ddd8176dfd37b91c83a46f1d4";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."forever-agent"."~0.6.0" =
    self.by-version."forever-agent"."0.6.1";
  by-version."forever-agent"."0.6.1" = self.buildNodePackage {
    name = "forever-agent-0.6.1";
    version = "0.6.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/forever-agent/-/forever-agent-0.6.1.tgz";
      name = "forever-agent-0.6.1.tgz";
      sha1 = "fbc71f0c41adeb37f96c577ad1ed42d8fdacca91";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."form-data"."~1.0.0-rc1" =
    self.by-version."form-data"."1.0.0-rc3";
  by-version."form-data"."1.0.0-rc3" = self.buildNodePackage {
    name = "form-data-1.0.0-rc3";
    version = "1.0.0-rc3";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/form-data/-/form-data-1.0.0-rc3.tgz";
      name = "form-data-1.0.0-rc3.tgz";
      sha1 = "d35bc62e7fbc2937ae78f948aaa0d38d90607577";
    };
    deps = {
      "async-1.4.2" = self.by-version."async"."1.4.2";
      "combined-stream-1.0.5" = self.by-version."combined-stream"."1.0.5";
      "mime-types-2.1.6" = self.by-version."mime-types"."2.1.6";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."generate-function"."^2.0.0" =
    self.by-version."generate-function"."2.0.0";
  by-version."generate-function"."2.0.0" = self.buildNodePackage {
    name = "generate-function-2.0.0";
    version = "2.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/generate-function/-/generate-function-2.0.0.tgz";
      name = "generate-function-2.0.0.tgz";
      sha1 = "6858fe7c0969b7d4e9093337647ac79f60dfbe74";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."generate-object-property"."^1.1.0" =
    self.by-version."generate-object-property"."1.2.0";
  by-version."generate-object-property"."1.2.0" = self.buildNodePackage {
    name = "generate-object-property-1.2.0";
    version = "1.2.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/generate-object-property/-/generate-object-property-1.2.0.tgz";
      name = "generate-object-property-1.2.0.tgz";
      sha1 = "9c0e1c40308ce804f4783618b937fa88f99d50d0";
    };
    deps = {
      "is-property-1.0.2" = self.by-version."is-property"."1.0.2";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."get-pixels"."^3.1.0" =
    self.by-version."get-pixels"."3.2.3";
  by-version."get-pixels"."3.2.3" = self.buildNodePackage {
    name = "get-pixels-3.2.3";
    version = "3.2.3";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/get-pixels/-/get-pixels-3.2.3.tgz";
      name = "get-pixels-3.2.3.tgz";
      sha1 = "c4a220fc87236cf692969a596378e0b6f813531e";
    };
    deps = {
      "ndarray-1.0.18" = self.by-version."ndarray"."1.0.18";
      "pngjs2-1.2.0" = self.by-version."pngjs2"."1.2.0";
      "ndarray-pack-1.1.1" = self.by-version."ndarray-pack"."1.1.1";
      "jpeg-js-0.1.1" = self.by-version."jpeg-js"."0.1.1";
      "omggif-1.0.8" = self.by-version."omggif"."1.0.8";
      "node-bitmap-0.0.1" = self.by-version."node-bitmap"."0.0.1";
      "through-2.3.8" = self.by-version."through"."2.3.8";
      "request-2.62.0" = self.by-version."request"."2.62.0";
      "parse-data-uri-0.2.0" = self.by-version."parse-data-uri"."0.2.0";
      "mime-types-2.1.6" = self.by-version."mime-types"."2.1.6";
      "data-uri-to-buffer-0.0.3" = self.by-version."data-uri-to-buffer"."0.0.3";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."gif-encoder"."~0.4.1" =
    self.by-version."gif-encoder"."0.4.1";
  by-version."gif-encoder"."0.4.1" = self.buildNodePackage {
    name = "gif-encoder-0.4.1";
    version = "0.4.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/gif-encoder/-/gif-encoder-0.4.1.tgz";
      name = "gif-encoder-0.4.1.tgz";
      sha1 = "0ec2192b35b91e50073258354b13d3e5165f106b";
    };
    deps = {
      "readable-stream-1.1.13" = self.by-version."readable-stream"."1.1.13";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."graceful-readlink".">= 1.0.0" =
    self.by-version."graceful-readlink"."1.0.1";
  by-version."graceful-readlink"."1.0.1" = self.buildNodePackage {
    name = "graceful-readlink-1.0.1";
    version = "1.0.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/graceful-readlink/-/graceful-readlink-1.0.1.tgz";
      name = "graceful-readlink-1.0.1.tgz";
      sha1 = "4cafad76bc62f02fa039b2f94e9a3dd3a391a725";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."har-validator"."^1.6.1" =
    self.by-version."har-validator"."1.8.0";
  by-version."har-validator"."1.8.0" = self.buildNodePackage {
    name = "har-validator-1.8.0";
    version = "1.8.0";
    bin = true;
    src = fetchurl {
      url = "http://registry.npmjs.org/har-validator/-/har-validator-1.8.0.tgz";
      name = "har-validator-1.8.0.tgz";
      sha1 = "d83842b0eb4c435960aeb108a067a3aa94c0eeb2";
    };
    deps = {
      "bluebird-2.10.0" = self.by-version."bluebird"."2.10.0";
      "chalk-1.1.1" = self.by-version."chalk"."1.1.1";
      "commander-2.8.1" = self.by-version."commander"."2.8.1";
      "is-my-json-valid-2.12.2" = self.by-version."is-my-json-valid"."2.12.2";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."has-ansi"."^2.0.0" =
    self.by-version."has-ansi"."2.0.0";
  by-version."has-ansi"."2.0.0" = self.buildNodePackage {
    name = "has-ansi-2.0.0";
    version = "2.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/has-ansi/-/has-ansi-2.0.0.tgz";
      name = "has-ansi-2.0.0.tgz";
      sha1 = "34f5049ce1ecdf2b0649af3ef24e45ed35416d91";
    };
    deps = {
      "ansi-regex-2.0.0" = self.by-version."ansi-regex"."2.0.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."hawk"."~3.1.0" =
    self.by-version."hawk"."3.1.0";
  by-version."hawk"."3.1.0" = self.buildNodePackage {
    name = "hawk-3.1.0";
    version = "3.1.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/hawk/-/hawk-3.1.0.tgz";
      name = "hawk-3.1.0.tgz";
      sha1 = "8a13ae19977ec607602f3f0b9fd676f18c384e44";
    };
    deps = {
      "hoek-2.16.2" = self.by-version."hoek"."2.16.2";
      "boom-2.8.0" = self.by-version."boom"."2.8.0";
      "cryptiles-2.0.5" = self.by-version."cryptiles"."2.0.5";
      "sntp-1.0.9" = self.by-version."sntp"."1.0.9";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."hoek"."2.x.x" =
    self.by-version."hoek"."2.16.2";
  by-version."hoek"."2.16.2" = self.buildNodePackage {
    name = "hoek-2.16.2";
    version = "2.16.2";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/hoek/-/hoek-2.16.2.tgz";
      name = "hoek-2.16.2.tgz";
      sha1 = "55887934ba67f8299ff8fe5a3feea137e948c80b";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."http-signature"."~0.11.0" =
    self.by-version."http-signature"."0.11.0";
  by-version."http-signature"."0.11.0" = self.buildNodePackage {
    name = "http-signature-0.11.0";
    version = "0.11.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/http-signature/-/http-signature-0.11.0.tgz";
      name = "http-signature-0.11.0.tgz";
      sha1 = "1796cf67a001ad5cd6849dca0991485f09089fe6";
    };
    deps = {
      "assert-plus-0.1.5" = self.by-version."assert-plus"."0.1.5";
      "asn1-0.1.11" = self.by-version."asn1"."0.1.11";
      "ctype-0.5.3" = self.by-version."ctype"."0.5.3";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."image-sdf"."*" =
    self.by-version."image-sdf"."1.0.4";
  by-version."image-sdf"."1.0.4" = self.buildNodePackage {
    name = "image-sdf-1.0.4";
    version = "1.0.4";
    bin = true;
    src = fetchurl {
      url = "http://registry.npmjs.org/image-sdf/-/image-sdf-1.0.4.tgz";
      name = "image-sdf-1.0.4.tgz";
      sha1 = "b7ab819ecf390610bdb461a76656e9b553cb7028";
    };
    deps = {
      "as-number-1.0.0" = self.by-version."as-number"."1.0.0";
      "clamp-1.0.1" = self.by-version."clamp"."1.0.1";
      "color-string-0.2.4" = self.by-version."color-string"."0.2.4";
      "get-pixels-3.2.3" = self.by-version."get-pixels"."3.2.3";
      "ndarray-1.0.18" = self.by-version."ndarray"."1.0.18";
      "save-pixels-2.2.0" = self.by-version."save-pixels"."2.2.0";
      "typedarray-pool-1.1.0" = self.by-version."typedarray-pool"."1.1.0";
      "yargs-1.3.3" = self.by-version."yargs"."1.3.3";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  "image-sdf" = self.by-version."image-sdf"."1.0.4";
  by-spec."inherits"."~2.0.1" =
    self.by-version."inherits"."2.0.1";
  by-version."inherits"."2.0.1" = self.buildNodePackage {
    name = "inherits-2.0.1";
    version = "2.0.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/inherits/-/inherits-2.0.1.tgz";
      name = "inherits-2.0.1.tgz";
      sha1 = "b17d08d326b4423e568eff719f91b0b1cbdf69f1";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."iota-array"."^1.0.0" =
    self.by-version."iota-array"."1.0.0";
  by-version."iota-array"."1.0.0" = self.buildNodePackage {
    name = "iota-array-1.0.0";
    version = "1.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/iota-array/-/iota-array-1.0.0.tgz";
      name = "iota-array-1.0.0.tgz";
      sha1 = "81ef57fe5d05814cd58c2483632a99c30a0e8087";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."is-buffer"."^1.0.2" =
    self.by-version."is-buffer"."1.1.0";
  by-version."is-buffer"."1.1.0" = self.buildNodePackage {
    name = "is-buffer-1.1.0";
    version = "1.1.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/is-buffer/-/is-buffer-1.1.0.tgz";
      name = "is-buffer-1.1.0.tgz";
      sha1 = "36f7850c0d077a71b041f3565664155f07035bd0";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."is-my-json-valid"."^2.12.0" =
    self.by-version."is-my-json-valid"."2.12.2";
  by-version."is-my-json-valid"."2.12.2" = self.buildNodePackage {
    name = "is-my-json-valid-2.12.2";
    version = "2.12.2";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/is-my-json-valid/-/is-my-json-valid-2.12.2.tgz";
      name = "is-my-json-valid-2.12.2.tgz";
      sha1 = "0d65859318c846ce3a134402fd3fbc504272ccc9";
    };
    deps = {
      "generate-function-2.0.0" = self.by-version."generate-function"."2.0.0";
      "generate-object-property-1.2.0" = self.by-version."generate-object-property"."1.2.0";
      "jsonpointer-2.0.0" = self.by-version."jsonpointer"."2.0.0";
      "xtend-4.0.0" = self.by-version."xtend"."4.0.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."is-property"."^1.0.0" =
    self.by-version."is-property"."1.0.2";
  by-version."is-property"."1.0.2" = self.buildNodePackage {
    name = "is-property-1.0.2";
    version = "1.0.2";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/is-property/-/is-property-1.0.2.tgz";
      name = "is-property-1.0.2.tgz";
      sha1 = "57fe1c4e48474edd65b09911f26b1cd4095dda84";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."isarray"."0.0.1" =
    self.by-version."isarray"."0.0.1";
  by-version."isarray"."0.0.1" = self.buildNodePackage {
    name = "isarray-0.0.1";
    version = "0.0.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/isarray/-/isarray-0.0.1.tgz";
      name = "isarray-0.0.1.tgz";
      sha1 = "8a18acfca9a8f4177e09abfc6038939b05d1eedf";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."isstream"."~0.1.1" =
    self.by-version."isstream"."0.1.2";
  by-version."isstream"."0.1.2" = self.buildNodePackage {
    name = "isstream-0.1.2";
    version = "0.1.2";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/isstream/-/isstream-0.1.2.tgz";
      name = "isstream-0.1.2.tgz";
      sha1 = "47e63f7af55afa6f92e1500e690eb8b8529c099a";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."jpeg-js"."0.0.4" =
    self.by-version."jpeg-js"."0.0.4";
  by-version."jpeg-js"."0.0.4" = self.buildNodePackage {
    name = "jpeg-js-0.0.4";
    version = "0.0.4";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/jpeg-js/-/jpeg-js-0.0.4.tgz";
      name = "jpeg-js-0.0.4.tgz";
      sha1 = "06aaf47efec7af0b1924a59cd695a6d2b5ed870e";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."jpeg-js"."^0.1.1" =
    self.by-version."jpeg-js"."0.1.1";
  by-version."jpeg-js"."0.1.1" = self.buildNodePackage {
    name = "jpeg-js-0.1.1";
    version = "0.1.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/jpeg-js/-/jpeg-js-0.1.1.tgz";
      name = "jpeg-js-0.1.1.tgz";
      sha1 = "2a5ff19636fe27e3b665ad9423475cb6b698698d";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."json-stringify-safe"."~5.0.0" =
    self.by-version."json-stringify-safe"."5.0.1";
  by-version."json-stringify-safe"."5.0.1" = self.buildNodePackage {
    name = "json-stringify-safe-5.0.1";
    version = "5.0.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/json-stringify-safe/-/json-stringify-safe-5.0.1.tgz";
      name = "json-stringify-safe-5.0.1.tgz";
      sha1 = "1296a2d58fd45f19a0f6ce01d65701e2c735b6eb";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."jsonpointer"."2.0.0" =
    self.by-version."jsonpointer"."2.0.0";
  by-version."jsonpointer"."2.0.0" = self.buildNodePackage {
    name = "jsonpointer-2.0.0";
    version = "2.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/jsonpointer/-/jsonpointer-2.0.0.tgz";
      name = "jsonpointer-2.0.0.tgz";
      sha1 = "3af1dd20fe85463910d469a385e33017d2a030d9";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."mime-db"."~1.18.0" =
    self.by-version."mime-db"."1.18.0";
  by-version."mime-db"."1.18.0" = self.buildNodePackage {
    name = "mime-db-1.18.0";
    version = "1.18.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/mime-db/-/mime-db-1.18.0.tgz";
      name = "mime-db-1.18.0.tgz";
      sha1 = "5317e28224c08af1d484f60973dd386ba8f389e0";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."mime-types"."^2.0.1" =
    self.by-version."mime-types"."2.1.6";
  by-version."mime-types"."2.1.6" = self.buildNodePackage {
    name = "mime-types-2.1.6";
    version = "2.1.6";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/mime-types/-/mime-types-2.1.6.tgz";
      name = "mime-types-2.1.6.tgz";
      sha1 = "949f8788411864ddc70948a0f21c43f29d25667c";
    };
    deps = {
      "mime-db-1.18.0" = self.by-version."mime-db"."1.18.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."mime-types"."^2.1.3" =
    self.by-version."mime-types"."2.1.6";
  by-spec."mime-types"."~2.1.2" =
    self.by-version."mime-types"."2.1.6";
  by-spec."ndarray"."^1.0.13" =
    self.by-version."ndarray"."1.0.18";
  by-version."ndarray"."1.0.18" = self.buildNodePackage {
    name = "ndarray-1.0.18";
    version = "1.0.18";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/ndarray/-/ndarray-1.0.18.tgz";
      name = "ndarray-1.0.18.tgz";
      sha1 = "b60d3a73224ec555d0faa79711e502448fd3f793";
    };
    deps = {
      "iota-array-1.0.0" = self.by-version."iota-array"."1.0.0";
      "is-buffer-1.1.0" = self.by-version."is-buffer"."1.1.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."ndarray"."^1.0.16" =
    self.by-version."ndarray"."1.0.18";
  by-spec."ndarray-pack"."^1.1.1" =
    self.by-version."ndarray-pack"."1.1.1";
  by-version."ndarray-pack"."1.1.1" = self.buildNodePackage {
    name = "ndarray-pack-1.1.1";
    version = "1.1.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/ndarray-pack/-/ndarray-pack-1.1.1.tgz";
      name = "ndarray-pack-1.1.1.tgz";
      sha1 = "e2bfb1ee7848f00ecd0bcd5b6bad2ce77d058331";
    };
    deps = {
      "ndarray-1.0.18" = self.by-version."ndarray"."1.0.18";
      "cwise-compiler-0.1.0" = self.by-version."cwise-compiler"."0.1.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."node-bitmap"."0.0.1" =
    self.by-version."node-bitmap"."0.0.1";
  by-version."node-bitmap"."0.0.1" = self.buildNodePackage {
    name = "node-bitmap-0.0.1";
    version = "0.0.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/node-bitmap/-/node-bitmap-0.0.1.tgz";
      name = "node-bitmap-0.0.1.tgz";
      sha1 = "180eac7003e0c707618ef31368f62f84b2a69091";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."node-uuid"."~1.4.0" =
    self.by-version."node-uuid"."1.4.3";
  by-version."node-uuid"."1.4.3" = self.buildNodePackage {
    name = "node-uuid-1.4.3";
    version = "1.4.3";
    bin = true;
    src = fetchurl {
      url = "http://registry.npmjs.org/node-uuid/-/node-uuid-1.4.3.tgz";
      name = "node-uuid-1.4.3.tgz";
      sha1 = "319bb7a56e7cb63f00b5c0cd7851cd4b4ddf1df9";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."oauth-sign"."~0.8.0" =
    self.by-version."oauth-sign"."0.8.0";
  by-version."oauth-sign"."0.8.0" = self.buildNodePackage {
    name = "oauth-sign-0.8.0";
    version = "0.8.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/oauth-sign/-/oauth-sign-0.8.0.tgz";
      name = "oauth-sign-0.8.0.tgz";
      sha1 = "938fdc875765ba527137d8aec9d178e24debc553";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."omggif"."^1.0.5" =
    self.by-version."omggif"."1.0.8";
  by-version."omggif"."1.0.8" = self.buildNodePackage {
    name = "omggif-1.0.8";
    version = "1.0.8";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/omggif/-/omggif-1.0.8.tgz";
      name = "omggif-1.0.8.tgz";
      sha1 = "178f37b2ab0b3d7b46ed3a0e46bd0790b58d3530";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."parse-data-uri"."^0.2.0" =
    self.by-version."parse-data-uri"."0.2.0";
  by-version."parse-data-uri"."0.2.0" = self.buildNodePackage {
    name = "parse-data-uri-0.2.0";
    version = "0.2.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/parse-data-uri/-/parse-data-uri-0.2.0.tgz";
      name = "parse-data-uri-0.2.0.tgz";
      sha1 = "bf04d851dd5c87b0ab238e5d01ace494b604b4c9";
    };
    deps = {
      "data-uri-to-buffer-0.0.3" = self.by-version."data-uri-to-buffer"."0.0.3";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."pngjs"."~0.4.0-alpha" =
    self.by-version."pngjs"."0.4.0";
  by-version."pngjs"."0.4.0" = self.buildNodePackage {
    name = "pngjs-0.4.0";
    version = "0.4.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/pngjs/-/pngjs-0.4.0.tgz";
      name = "pngjs-0.4.0.tgz";
      sha1 = "294071adc1b2b60bfd4aca4dbe4759bccee6fd77";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."pngjs2"."^1.0.0" =
    self.by-version."pngjs2"."1.2.0";
  by-version."pngjs2"."1.2.0" = self.buildNodePackage {
    name = "pngjs2-1.2.0";
    version = "1.2.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/pngjs2/-/pngjs2-1.2.0.tgz";
      name = "pngjs2-1.2.0.tgz";
      sha1 = "c62ff4c4c51d2c919494b761a6f4993f4d7fe569";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."process-nextick-args"."~1.0.0" =
    self.by-version."process-nextick-args"."1.0.3";
  by-version."process-nextick-args"."1.0.3" = self.buildNodePackage {
    name = "process-nextick-args-1.0.3";
    version = "1.0.3";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/process-nextick-args/-/process-nextick-args-1.0.3.tgz";
      name = "process-nextick-args-1.0.3.tgz";
      sha1 = "e272eed825d5e9f4ea74d8d73b1fe311c3beb630";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."qs"."~5.1.0" =
    self.by-version."qs"."5.1.0";
  by-version."qs"."5.1.0" = self.buildNodePackage {
    name = "qs-5.1.0";
    version = "5.1.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/qs/-/qs-5.1.0.tgz";
      name = "qs-5.1.0.tgz";
      sha1 = "4d932e5c7ea411cca76a312d39a606200fd50cd9";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."readable-stream"."~1.0.33-1" =
    self.by-version."readable-stream"."1.0.33";
  by-version."readable-stream"."1.0.33" = self.buildNodePackage {
    name = "readable-stream-1.0.33";
    version = "1.0.33";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/readable-stream/-/readable-stream-1.0.33.tgz";
      name = "readable-stream-1.0.33.tgz";
      sha1 = "3a360dd66c1b1d7fd4705389860eda1d0f61126c";
    };
    deps = {
      "core-util-is-1.0.1" = self.by-version."core-util-is"."1.0.1";
      "isarray-0.0.1" = self.by-version."isarray"."0.0.1";
      "string_decoder-0.10.31" = self.by-version."string_decoder"."0.10.31";
      "inherits-2.0.1" = self.by-version."inherits"."2.0.1";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."readable-stream"."~1.1.9" =
    self.by-version."readable-stream"."1.1.13";
  by-version."readable-stream"."1.1.13" = self.buildNodePackage {
    name = "readable-stream-1.1.13";
    version = "1.1.13";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/readable-stream/-/readable-stream-1.1.13.tgz";
      name = "readable-stream-1.1.13.tgz";
      sha1 = "f6eef764f514c89e2b9e23146a75ba106756d23e";
    };
    deps = {
      "core-util-is-1.0.1" = self.by-version."core-util-is"."1.0.1";
      "isarray-0.0.1" = self.by-version."isarray"."0.0.1";
      "string_decoder-0.10.31" = self.by-version."string_decoder"."0.10.31";
      "inherits-2.0.1" = self.by-version."inherits"."2.0.1";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."readable-stream"."~2.0.0" =
    self.by-version."readable-stream"."2.0.2";
  by-version."readable-stream"."2.0.2" = self.buildNodePackage {
    name = "readable-stream-2.0.2";
    version = "2.0.2";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/readable-stream/-/readable-stream-2.0.2.tgz";
      name = "readable-stream-2.0.2.tgz";
      sha1 = "bec81beae8cf455168bc2e5b2b31f5bcfaed9b1b";
    };
    deps = {
      "core-util-is-1.0.1" = self.by-version."core-util-is"."1.0.1";
      "inherits-2.0.1" = self.by-version."inherits"."2.0.1";
      "isarray-0.0.1" = self.by-version."isarray"."0.0.1";
      "process-nextick-args-1.0.3" = self.by-version."process-nextick-args"."1.0.3";
      "string_decoder-0.10.31" = self.by-version."string_decoder"."0.10.31";
      "util-deprecate-1.0.1" = self.by-version."util-deprecate"."1.0.1";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."request"."^2.44.0" =
    self.by-version."request"."2.62.0";
  by-version."request"."2.62.0" = self.buildNodePackage {
    name = "request-2.62.0";
    version = "2.62.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/request/-/request-2.62.0.tgz";
      name = "request-2.62.0.tgz";
      sha1 = "55c165f702a146f1e21e0725c0b75e1136487b0f";
    };
    deps = {
      "bl-1.0.0" = self.by-version."bl"."1.0.0";
      "caseless-0.11.0" = self.by-version."caseless"."0.11.0";
      "extend-3.0.0" = self.by-version."extend"."3.0.0";
      "forever-agent-0.6.1" = self.by-version."forever-agent"."0.6.1";
      "form-data-1.0.0-rc3" = self.by-version."form-data"."1.0.0-rc3";
      "json-stringify-safe-5.0.1" = self.by-version."json-stringify-safe"."5.0.1";
      "mime-types-2.1.6" = self.by-version."mime-types"."2.1.6";
      "node-uuid-1.4.3" = self.by-version."node-uuid"."1.4.3";
      "qs-5.1.0" = self.by-version."qs"."5.1.0";
      "tunnel-agent-0.4.1" = self.by-version."tunnel-agent"."0.4.1";
      "tough-cookie-2.0.0" = self.by-version."tough-cookie"."2.0.0";
      "http-signature-0.11.0" = self.by-version."http-signature"."0.11.0";
      "oauth-sign-0.8.0" = self.by-version."oauth-sign"."0.8.0";
      "hawk-3.1.0" = self.by-version."hawk"."3.1.0";
      "aws-sign2-0.5.0" = self.by-version."aws-sign2"."0.5.0";
      "stringstream-0.0.4" = self.by-version."stringstream"."0.0.4";
      "combined-stream-1.0.5" = self.by-version."combined-stream"."1.0.5";
      "isstream-0.1.2" = self.by-version."isstream"."0.1.2";
      "har-validator-1.8.0" = self.by-version."har-validator"."1.8.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."save-pixels"."^2.2.0" =
    self.by-version."save-pixels"."2.2.0";
  by-version."save-pixels"."2.2.0" = self.buildNodePackage {
    name = "save-pixels-2.2.0";
    version = "2.2.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/save-pixels/-/save-pixels-2.2.0.tgz";
      name = "save-pixels-2.2.0.tgz";
      sha1 = "beab5d74a4400731b22474b2e477f7626bfd193f";
    };
    deps = {
      "contentstream-1.0.0" = self.by-version."contentstream"."1.0.0";
      "gif-encoder-0.4.1" = self.by-version."gif-encoder"."0.4.1";
      "jpeg-js-0.0.4" = self.by-version."jpeg-js"."0.0.4";
      "pngjs-0.4.0" = self.by-version."pngjs"."0.4.0";
      "through-2.3.8" = self.by-version."through"."2.3.8";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."sntp"."1.x.x" =
    self.by-version."sntp"."1.0.9";
  by-version."sntp"."1.0.9" = self.buildNodePackage {
    name = "sntp-1.0.9";
    version = "1.0.9";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/sntp/-/sntp-1.0.9.tgz";
      name = "sntp-1.0.9.tgz";
      sha1 = "6541184cc90aeea6c6e7b35e2659082443c66198";
    };
    deps = {
      "hoek-2.16.2" = self.by-version."hoek"."2.16.2";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."string_decoder"."~0.10.x" =
    self.by-version."string_decoder"."0.10.31";
  by-version."string_decoder"."0.10.31" = self.buildNodePackage {
    name = "string_decoder-0.10.31";
    version = "0.10.31";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/string_decoder/-/string_decoder-0.10.31.tgz";
      name = "string_decoder-0.10.31.tgz";
      sha1 = "62e203bc41766c6c28c9fc84301dab1c5310fa94";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."stringstream"."~0.0.4" =
    self.by-version."stringstream"."0.0.4";
  by-version."stringstream"."0.0.4" = self.buildNodePackage {
    name = "stringstream-0.0.4";
    version = "0.0.4";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/stringstream/-/stringstream-0.0.4.tgz";
      name = "stringstream-0.0.4.tgz";
      sha1 = "0f0e3423f942960b5692ac324a57dd093bc41a92";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."strip-ansi"."^3.0.0" =
    self.by-version."strip-ansi"."3.0.0";
  by-version."strip-ansi"."3.0.0" = self.buildNodePackage {
    name = "strip-ansi-3.0.0";
    version = "3.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/strip-ansi/-/strip-ansi-3.0.0.tgz";
      name = "strip-ansi-3.0.0.tgz";
      sha1 = "7510b665567ca914ccb5d7e072763ac968be3724";
    };
    deps = {
      "ansi-regex-2.0.0" = self.by-version."ansi-regex"."2.0.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."supports-color"."^2.0.0" =
    self.by-version."supports-color"."2.0.0";
  by-version."supports-color"."2.0.0" = self.buildNodePackage {
    name = "supports-color-2.0.0";
    version = "2.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/supports-color/-/supports-color-2.0.0.tgz";
      name = "supports-color-2.0.0.tgz";
      sha1 = "535d045ce6b6363fa40117084629995e9df324c7";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."through"."^2.3.4" =
    self.by-version."through"."2.3.8";
  by-version."through"."2.3.8" = self.buildNodePackage {
    name = "through-2.3.8";
    version = "2.3.8";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/through/-/through-2.3.8.tgz";
      name = "through-2.3.8.tgz";
      sha1 = "0dd4c9ffaabc357960b1b724115d7e0e86a2e1f5";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."tough-cookie".">=0.12.0" =
    self.by-version."tough-cookie"."2.0.0";
  by-version."tough-cookie"."2.0.0" = self.buildNodePackage {
    name = "tough-cookie-2.0.0";
    version = "2.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/tough-cookie/-/tough-cookie-2.0.0.tgz";
      name = "tough-cookie-2.0.0.tgz";
      sha1 = "41ce08720b35cf90beb044dd2609fb19e928718f";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."tunnel-agent"."~0.4.0" =
    self.by-version."tunnel-agent"."0.4.1";
  by-version."tunnel-agent"."0.4.1" = self.buildNodePackage {
    name = "tunnel-agent-0.4.1";
    version = "0.4.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/tunnel-agent/-/tunnel-agent-0.4.1.tgz";
      name = "tunnel-agent-0.4.1.tgz";
      sha1 = "bbeecff4d679ce753db9462761a88dfcec3c5ab3";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."typedarray-pool"."^1.1.0" =
    self.by-version."typedarray-pool"."1.1.0";
  by-version."typedarray-pool"."1.1.0" = self.buildNodePackage {
    name = "typedarray-pool-1.1.0";
    version = "1.1.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/typedarray-pool/-/typedarray-pool-1.1.0.tgz";
      name = "typedarray-pool-1.1.0.tgz";
      sha1 = "d114f484801489f53ecab5e8088aa23044f498d9";
    };
    deps = {
      "bit-twiddle-1.0.2" = self.by-version."bit-twiddle"."1.0.2";
      "dup-1.0.0" = self.by-version."dup"."1.0.0";
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."uniq"."~0.0.2" =
    self.by-version."uniq"."0.0.2";
  by-version."uniq"."0.0.2" = self.buildNodePackage {
    name = "uniq-0.0.2";
    version = "0.0.2";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/uniq/-/uniq-0.0.2.tgz";
      name = "uniq-0.0.2.tgz";
      sha1 = "614e868ba288651d351262369317acc43b901823";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."util-deprecate"."~1.0.1" =
    self.by-version."util-deprecate"."1.0.1";
  by-version."util-deprecate"."1.0.1" = self.buildNodePackage {
    name = "util-deprecate-1.0.1";
    version = "1.0.1";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/util-deprecate/-/util-deprecate-1.0.1.tgz";
      name = "util-deprecate-1.0.1.tgz";
      sha1 = "3556a3d13c4c6aa7983d7e2425478197199b7881";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."xtend"."^4.0.0" =
    self.by-version."xtend"."4.0.0";
  by-version."xtend"."4.0.0" = self.buildNodePackage {
    name = "xtend-4.0.0";
    version = "4.0.0";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/xtend/-/xtend-4.0.0.tgz";
      name = "xtend-4.0.0.tgz";
      sha1 = "8bc36ff87aedbe7ce9eaf0bca36b2354a743840f";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
  by-spec."yargs"."^1.3.3" =
    self.by-version."yargs"."1.3.3";
  by-version."yargs"."1.3.3" = self.buildNodePackage {
    name = "yargs-1.3.3";
    version = "1.3.3";
    bin = false;
    src = fetchurl {
      url = "http://registry.npmjs.org/yargs/-/yargs-1.3.3.tgz";
      name = "yargs-1.3.3.tgz";
      sha1 = "054de8b61f22eefdb7207059eaef9d6b83fb931a";
    };
    deps = {
    };
    optionalDependencies = {
    };
    peerDependencies = [];
    os = [ ];
    cpu = [ ];
  };
}
