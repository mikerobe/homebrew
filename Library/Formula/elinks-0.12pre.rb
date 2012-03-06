require 'formula'

class Elinks012pre < Formula
  url 'http://elinks.or.cz/download/elinks-0.12pre5.tar.gz'
  homepage 'http://elinks.or.cz/'
  md5 '93b48cc31fb2eabbf8b1b96c262db397'

  fails_with_llvm :build => 2326

  def install
    ENV.deparallelize
    ENV.delete('LD')
    system "./autogen.sh" if ARGV.build_head?
    system "./configure", "--prefix=#{prefix}", "--without-spidermonkey", "--enable-fastmem"
    system "make install"
  end

  def test
    system "#{bin}/elinks"
  end
end
