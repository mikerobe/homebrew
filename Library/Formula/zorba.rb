require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Zorba < Formula
  homepage ''
  url 'https://launchpad.net/zorba/trunk/2.8/+download/zorba-2.8.0.tar.gz'
  version '2.8.0'
  sha1 '4e0dc400f0bd354fade009f1ed1eb45184b468f5'

  depends_on 'cmake' => :build
  depends_on 'icu4c'
  depends_on 'xerces-c'
  depends_on 'swig' => :build

  def options
    [
      ['--disable-big-integer', 'Use 64-bit instead of arbitrary precision integers for performance']
    ]
  end

  def install
    icu4c = Formula.factory('icu4c')
    mktemp do
      args = [std_cmake_parameters]
      # use ICU4C from keg
      args << "-DICU_INCLUDE_DIR=#{icu4c.include}"
      args << "-DICU_LIBRARY_DIR=#{icu4c.lib}"
      # macos comes with libxslt so we may as well use it
      args << "-DZORBA_XQUERYX=ON"
      args << "-DZORBA_WITH_BIG_INTEGER=OFF" if ARGV.include? '--disable-big-integer'
      args << "-DZORBA_SUPPRESS_SWIG=YES"
      system "cmake #{args.join ' '} #{buildpath}"
      system "make install"
    end
  end

  def test
    system "zorba -r -q '1 + 1'"
  end
end
