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

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
