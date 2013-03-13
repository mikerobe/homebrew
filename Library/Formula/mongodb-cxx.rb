require 'formula'

class MongodbCxx < Formula
  homepage 'http://docs.mongodb.org/ecosystem/drivers/cpp/'
  url 'http://downloads.mongodb.org/cxx-driver/mongodb-linux-x86_64-2.2.3.tgz'
  sha1 '2d8853270e63da55a24a30afc93c396f7ec57b94'
  head 'http://downloads.mongodb.org/cxx-driver/mongodb-linux-x86_64-latest.tgz'

  depends_on 'scons' => :build

  if build.head?
    # depends_on 'boost'
  else
    # TODO: how to use this in the scons-based build?
    depends_on 'boost149'
    old_boost = Formula.factory("boost149")
  end

  def patches
    DATA
  end

  def install
    ENV['CXXFLAGS'] = '-std=c++11 -stdlib=libc++'

    # -j#{ENV.make_jobs} may lead to race conditions on scons link...
    system "scons", "-j#{ENV.make_jobs}", "--prefix=#{prefix}", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <mongo/client/dbclient.h>
      int main() { mongo::DBClientConnection c; }
    EOS
    system ENV.cxx, *%w(-lmongoclient -lboost_thread-mt -lboost_filesystem-mt -lboost_system-mt -o test test.cpp)
    system "./test"
  end
end

__END__
diff --git a/SConstruct b/SConstruct
index 0bf69a5..32dc581 100755
--- a/SConstruct
+++ b/SConstruct
@@ -4,6 +4,7 @@
 
 import os
 import sys
+import SCons.Util
 
 # options
 AddOption("--extrapath",
@@ -30,6 +31,19 @@ env = Environment(BUILD_DIR='#build',
                   MSVS_ARCH=None,
                   PYTHON=sys.executable)
 
+if os.environ.has_key('CC'):
+	env['CC'] = os.environ['CC']
+if os.environ.has_key('CFLAGS'):
+	env['CCFLAGS'] += SCons.Util.CLVar(os.environ['CFLAGS'])
+if os.environ.has_key('CXX'):
+	env['CXX'] = os.environ['CXX']
+if os.environ.has_key('CXXFLAGS'):
+	env['CXXFLAGS'] += SCons.Util.CLVar(os.environ['CXXFLAGS'])
+if os.environ.has_key('CPPFLAGS'):
+	env['CCFLAGS'] += SCons.Util.CLVar(os.environ['CPPFLAGS'])
+if os.environ.has_key('LDFLAGS'):
+	env['LINKFLAGS'] += SCons.Util.CLVar(os.environ['LDFLAGS'])
+
 def addExtraLibs(s):
     for x in s.split(","):
         if os.path.exists(x):
