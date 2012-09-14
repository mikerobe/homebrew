require 'formula'

class Gtkx < Formula
  homepage 'http://gtk.org/'
  url 'http://ftp.acc.umu.se/pub/gnome/sources/gtk+/3.5/gtk+-3.5.2.tar.xz'
  sha256 '86529b658c714eb97ed76fd58cdb7fcdf30956a8664fbca97c7b1424a3bb35cf'

  depends_on 'pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'glib'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'gdk-pixbuf'
  depends_on 'pango'
  depends_on 'jasper' => :optional
  depends_on 'atk' => :optional
  depends_on 'cairo'
  depends_on :x11

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--disable-introspection",
                          "--disable-visibility"
    system "make install"
  end

  def test
    system "#{bin}/gtk-demo"
  end
end
