require 'formula'

class Goffice < Formula
  homepage 'http://projects.gnome.org/gnumeric/'
  url 'http://ftp.acc.umu.se/pub/GNOME/sources/goffice/0.9/goffice-0.9.3.tar.xz'
  sha256 '3024f94b334a45ff3fb3d3d3df6c7076b062fb3ed48286cb1516d65537642a51'

  depends_on 'pkg-config' => :build
  depends_on 'gettext'
  depends_on 'intltool'
  depends_on 'libgsf'
  depends_on 'librsvg'
  depends_on 'gtk+'
  depends_on 'pcre'
  depends_on :x11

  # Fix for goffice trying to use a retired pcre api. Reported/source = Macports
  # https://github.com/mxcl/homebrew/issues/15171
  def patches
    DATA
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end

__END__
--- a/goffice/utils/regutf8.c	2009-09-05 16:52:09.000000000 -0700
+++ b/goffice/utils/regutf8.c	2012-09-28 20:53:51.000000000 -0700
@@ -155,7 +155,7 @@
		default: return GO_REG_BADPAT;
		}
	} else {
-		gor->re_nsub = pcre_info (r, NULL, NULL);
+		gor->re_nsub = pcre_fullinfo (r, NULL, 0, NULL);
		gor->nosub = (cflags & GO_REG_NOSUB) != 0;
		return 0;
	}
