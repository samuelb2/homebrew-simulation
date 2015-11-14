class Ogre < Formula
  desc "Object-Oriented Graphics Rendering Engine"
  homepage "http://www.ogre3d.org/"
  url "http://downloads.sourceforge.net/project/ogre/ogre/1.8/1.8.1/ogre_src_v1-8-1.tar.bz2"
  version "1.8.1"
  sha256 "afa475803d9e6980ddf3641dceaa53fcfbd348506ed67893c306766c166a4882"
  head "https://bitbucket.org/sinbad/ogre", :branch => "v2-1", :using => :hg

  bottle do
    root_url "http://gazebosim.org/distributions/ogre/releases"
    sha256 "8041b0541b4aa3bd57ed53ad83f10acc0c98e5aa622cad362bc2c280cadab3af" => :el_capitan
    sha256 "193c5c5eb56ed471fd5d9c73ed0dc2c6c41c17b75df2ae7174c7d66ff1cfba38" => :yosemite
  end

  option "with-cg"

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "doxygen"
  depends_on "freeimage"
  depends_on "freetype"
  depends_on "libzzip"
  depends_on "tbb"
  depends_on :x11

  def install
    ENV.m64

    cmake_args = [
      "-DCMAKE_OSX_ARCHITECTURES='x86_64'"
    ]
    cmake_args << "-DOGRE_BUILD_PLUGIN_CG=OFF" if build.without? "cg"
    cmake_args.concat(std_cmake_args)
    cmake_args << ".."

    mkdir "build" do
      system "cmake", *cmake_args
      system "make", "install"
    end
  end
end
