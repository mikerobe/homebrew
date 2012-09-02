require 'formula'

class Mkvtoolnix < Formula
  url 'http://www.bunkus.org/videotools/mkvtoolnix/sources/mkvtoolnix-5.7.0.tar.bz2'
  sha1 'c0ec30ef79435b287d52253abe45b105c77434ce'
  head 'https://github.com/mbunkus/mkvtoolnix.git'

  depends_on 'boost'
  depends_on 'libvorbis'
  depends_on 'libebml'
  depends_on 'libmatroska'
  depends_on 'flac' => :optional
  depends_on 'lzo' => :optional

  fails_with :clang do
    build 318
    cause "Compilation errors with older clang."
  end

  # Patch to build with #define foreach BOOST_FOREACH
  # See: https://svn.boost.org/trac/boost/ticket/6131
  def patches
    DATA unless build.head?
  end

  def install
    ENV['CXX'] = 'g++-4.7'
    ENV['CC'] = 'gcc-4.7'
    ENV['LD'] = 'gcc-4.7'
    ENV['CXXFLAGS'] = '-Os -Wall -Wextra -pipe -Woverloaded-virtual -std=c++11'
    ENV['CFLAGS'] = '-Wall -Wextra -pipe'

    system "./configure",
                          "CXXFLAGS=-std=c++11",
                          "--disable-debug",
                          "--prefix=#{prefix}",
                          "--with-boost-libdir=#{HOMEBREW_PREFIX}/lib", # For non-/usr/local prefix
                          "--with-boost-regex=boost_regex-mt" # via macports
    system "./drake", "-j#{ENV.make_jobs}"
    system "./drake install"
  end
end

__END__
diff --git a/src/common/common.h b/src/common/common.h
index 16f7177..8e9e053 100644
--- a/src/common/common.h
+++ b/src/common/common.h
@@ -17,7 +17,6 @@
 #undef min
 #undef max

-#include <boost/foreach.hpp>
 #include <boost/format.hpp>
 #include <boost/regex.hpp>
 #include <string>
@@ -83,6 +82,7 @@ extern unsigned int MTX_DLL_API verbose;

 #define foreach                  BOOST_FOREACH
 #define reverse_foreach          BOOST_REVERSE_FOREACH
+#include <boost/foreach.hpp>
 #define mxforeach(it, vec)       for (it = (vec).begin(); it != (vec).end(); it++)
 #define mxfind(value, cont)      std::find(cont.begin(), cont.end(), value)
 #define mxfind2(it, value, cont) ((it = std::find((cont).begin(), (cont).end(), value)) != (cont).end())
