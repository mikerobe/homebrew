require 'formula'

class Protobuf < Formula
  homepage 'http://code.google.com/p/protobuf/'
  url 'http://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2'
  sha1 '62c10dcdac4b69cc8c6bb19f73db40c264cb2726'

  option :universal

  fails_with :llvm do
    build 2334
  end

  def patches
    DATA unless build.head?
  end

  def install
    # Don't build in debug mode. See:
    # https://github.com/mxcl/homebrew/issues/9279
    # http://code.google.com/p/protobuf/source/browse/trunk/configure.ac#61
    ENV.prepend 'CXXFLAGS', '-DNDEBUG'
    ENV['CXXFLAGS'] += ' -std=c++11 -stdlib=libc++'
    ENV['LIBS'] = ' -lc++ -lc++abi'
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-zlib"
    system "make"
    system "make install"

    # Install editor support and examples
    doc.install %w( editors examples )
  end

  def caveats; <<-EOS.undent
    Editor support and examples have been installed to:
      #{doc}
    EOS
  end
end


__END__
diff --git a/src/google/protobuf/compiler/command_line_interface.cc b/src/google/protobuf/compiler/command_line_interface.cc
index 1c76994..c319333 100644
--- a/src/google/protobuf/compiler/command_line_interface.cc
+++ b/src/google/protobuf/compiler/command_line_interface.cc
@@ -32,6 +32,7 @@
 //  Based on original Protocol Buffers design by
 //  Sanjay Ghemawat, Jeff Dean, and others.
 
+#include <utility>
 #include <google/protobuf/compiler/command_line_interface.h>
 
 #include <stdio.h>
@@ -910,7 +911,7 @@ bool CommandLineInterface::InterpretArgument(const string& name,
         cerr << disk_path << ": warning: directory does not exist." << endl;
       }
 
-      proto_path_.push_back(make_pair<string, string>(virtual_path, disk_path));
+      proto_path_.push_back(make_pair(virtual_path, disk_path));
     }
 
   } else if (name == "-o" || name == "--descriptor_set_out") {
diff --git a/src/google/protobuf/message.cc b/src/google/protobuf/message.cc
index 91e6878..cfee383 100644
--- a/src/google/protobuf/message.cc
+++ b/src/google/protobuf/message.cc
@@ -32,6 +32,7 @@
 //  Based on original Protocol Buffers design by
 //  Sanjay Ghemawat, Jeff Dean, and others.
 
+#include <iostream>
 #include <stack>
 #include <google/protobuf/stubs/hash.h>
 
