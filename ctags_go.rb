require 'formula'

class CtagsGo < Formula
  homepage 'https://github.com/lyosha/ctags-go'
  head 'git://github.com/lyosha/ctags-go.git'

  depends_on :autoconf

  fails_with :llvm do
    build 2335
    cause 'Resulting executable generates erroneous tag files'
  end

  def install
    # See https://trac.macports.org/changeset/93604
    ENV.O1

    if build.head?
      system 'autoheader'
      system 'autoconf'
    end

    system './configure',
      "--prefix=#{prefix}",
      '--enable-macro-patterns',
      "--mandir=#{man}",
      '--with-readlib'
    system 'make install'
  end
end
