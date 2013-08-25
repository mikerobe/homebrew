require 'formula'

class Vim < Formula
  homepage 'http://www.vim.org/'
  # Get the base 7.4 tarball from Vim.org. But once patches start again, go
  # back to tracking Debian unstable here:
  # http://ftp.de.debian.org/debian/pool/main/v/vim/
  url 'http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2'
  sha1 '601abf7cc2b5ab186f40d8790e542f86afca86b7'

  # # Get stable versions from hg repo instead of downloading an increasing
  # # number of separate patches.
  # url 'https://vim.googlecode.com/hg/', :tag => 'v7-3-682'
  # version '7.3.682'

  head 'https://vim.googlecode.com/hg/'

  # We only have special support for finding depends_on :python, but not yet for
  # :ruby, :perl etc., so we use the standard environment that leaves the
  # PATH as the user has set it right now.
  env :std

  option "override-system-vi", "Override system vi"
  option "disable-nls", "Build vim without National Language Support (translated messages, keymaps)"

  LANGUAGES         = %w(lua mzscheme perl python python3 tcl ruby)
  DEFAULT_LANGUAGES = %w(ruby python python3 perl)

  LANGUAGES_OPTIONAL.each do |language|
    option "with-#{language}", "Build vim with #{language} support"
  end
  LANGUAGES_DEFAULT.each do |language|
    option "without-#{language}", "Build vim without #{language} support"
  end

  depends_on :hg => :build if build.head?
  depends_on :python => :recommended

  def install
    ENV['LUA_PREFIX'] = HOMEBREW_PREFIX

    opts = []
    opts += LANGUAGES_OPTIONAL.map do |language|
      "--enable-#{language}interp" if build.with? language
    end
    opts += LANGUAGES_DEFAULT.map do |language|
      "--enable-#{language}interp" unless build.without? language
    end

    opts << "--disable-nls" if build.include? "disable-nls"

    if python
      if python.brewed?
        # Avoid that vim always links System's Python even if configure tells us
        # it has found a brewed Python. Verify with `otool -L`.
        ENV.prepend 'LDFLAGS', "-F#{python.framework}"
      elsif python.from_osx? && !MacOS::CLT.installed?
        # Avoid `Python.h not found` on 10.8 with Xcode-only
        ENV.append 'CFLAGS', "-I#{python.incdir}", ' '
        # opts << "--with-python-config-dir=#{python.libdir}"
      end
    end

    # XXX: Please do not submit a pull request that hardcodes the path
    # to ruby: vim can be compiled against 1.8.x or 1.9.3-p385 and up.
    # If you have problems with vim because of ruby, ensure a compatible
    # version is first in your PATH when building vim.

    # We specify HOMEBREW_PREFIX as the prefix to make vim look in the
    # the right place (HOMEBREW_PREFIX/share/vim/{vimrc,vimfiles}) for
    # system vimscript files. We specify the normal installation prefix
    # when calling "make install".
    system "./configure", "--prefix=#{HOMEBREW_PREFIX}",
                          "--mandir=#{man}",
                          "--enable-gui=no",
                          "--without-x",
                          "--enable-multibyte",
                          "--with-tlib=ncurses",
                          "--enable-cscope",
                          "--with-features=huge",
                          "--with-compiledby=Homebrew",
                          "--enable-conceal",
                          *opts
    system "make"
    # If stripping the binaries is not enabled, vim will segfault with
    # statically-linked interpreters like ruby
    # http://code.google.com/p/vim/issues/detail?id=114&thanks=114&ts=1361483471
    system "make", "install", "prefix=#{prefix}", "STRIP=/usr/bin/true"
    ln_s bin+'vim', bin+'vi' if build.include? 'override-system-vi'
  end

  def patches
      # "https://raw.github.com/jezcope/vim-breakindent/master/breakindent.patch"
      "https://retracile.net/raw-attachment/blog/2012/12/21/17.30/vim-7.3.682-breakindent.patch"
      # "https://retracile.net/raw-attachment/blog/2011/08/23/21.30/vim-7.3.285-breakindent.patch"
  end

  def test
    system "#{bin}/vim"
  end
end
