# <span id="top">Playing with Kafka on Windows</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:60px;max-width:100px;">
    <a href="https://kafka.apache.org/" rel="external"><img style="border:0;" src="./docs/images/apache-kafka.png" alt="Kafka project"/></a>
  </td>
  <td style="border:0;padding:0;vertical-align:text-top;">
    This repository gathers <a href="https://kafka.apache.org/" rel="external">Kafka</a> code examples coming from various websites or written by myself.<br/>
    In particular it includes several <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a>/<a href="https://www.gnu.org/software/bash/manual/bash.html" rel="external">bash scripts</a> for experimenting with the <a href="https://kafka.apache.org" rel="external">Kafka</a> system on a Windows machine.
  </td>
  </tr>
</table>

> **:mag_right:** [Kafka] is a distributed system consisting of servers and clients that communicate via a high-performance TCP network protocol. It can be deployed on bare-metal hardware, virtual machines, and containers in on-premise as well as cloud environments. 

[Ada][ada_examples], [Akka][akka_examples], [Dart][dart_examples], [Deno][deno_examples], [Flix][flix_examples], [Golang][golang_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Node.js][nodejs_examples], [Rust][rust_examples], [Scala 3][scala3_examples], [Spark][spark_examples], [Spring][spring_examples], [TruffleSqueak][trufflesqueak_examples] and [WiX Toolset][wix_examples] are other trending topics we are continuously monitoring.

## <span id="proj_deps">Project dependencies</span>

This project depends on the following external software for the **Microsoft Windows** platform:

- [Git 2.39][git_releases] ([*release notes*][git_relnotes])
- [Kafka 3.3][kafka_downloads] ([*release notes*][kafka_relnotes])
- [Temurin OpenJDK 17 LTS][temurin_opendjk17] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][temurin_opendjk17_relnotes], [*bug fixes*][temurin_opendjk17_bugfixes])

Optionally one may also install the following software:

- [Offset Explorer 2.3][kafkatool_downloads] ([*change history*][kafkatool_changes])
- [Temurin OpenJDK 11 LTS][temurin_opendjk11] ([*release notes*][temurin_opendjk11_relnotes], [*bug fixes*][temurin_opendjk11_bugfixes])

> **&#9755;** ***Installation policy***<br/>
> When possible we install software from a [Zip archive][zip_archive] rather than via a [Windows installer][windows_installer]. In our case we defined **`C:\opt\`** as the installation directory for optional software tools (*in reference to* the [`/opt/`][unix_opt] directory on Unix).

For instance our development environment looks as follows (*January 2023*) <sup id="anchor_02">[2](#footnote_02)</sup>:

<pre style="font-size:80%;">
C:\opt\apache-maven-3.8.7\         <i>( 10 MB)</i>
C:\opt\Git-2.39.1\                 <i>(304 MB)</i>
C:\opt\jdk-temurin-11.0.18_10\     <i>(302 MB)</i>
C:\opt\jdk-temurin-17.0.6_10\      <i>(299 MB)</i>
C:\opt\kafka_2.13-3.3.2\           <i>(105 MB)</i>
C:\opt\scala-2.13.10\              <i>( 23 MB)</i>
C:\Program Files\OffsetExplorer2\  <i>(112 MB)</i>
</pre>

> **:mag_right:** [Git for Windows][git_downloads] provides a BASH emulation used to run [**`git`**][git_cli] from the command line (as well as over 250 Unix commands like [**`awk`**][man1_awk], [**`diff`**][man1_diff], [**`file`**][man1_file], [**`grep`**][man1_grep], [**`more`**][man1_more], [**`mv`**][man1_mv], [**`rmdir`**][man1_rmdir], [**`sed`**][man1_sed] and [**`wc`**][man1_wc]).

## <span id="structure">Directory structure</span> [**&#x25B4;**](#top)

This project is organized as follows:

<pre style="font-size:80%;">
docs\
examples\{<a href="examples/README.md">README.md</a>, <a href="examples/quickstart/">quickstart</a>, ..}
<a href="https://github.com/apache/kafka">kafka\</a> <i>(<a href="./.gitmodules">git module</a>)</i>
README.md
<a href="RESOURCES.md">RESOURCES.md</a>
<a href="setenv.bat">setenv.bat</a>
</pre>

where

- directory [**`docs\`**](docs/) contains [Kafka] related papers/articles.
- directory [**`examples\`**](examples/) contains [Kafka] examples grabbed from various websites (see file [**`examples\README.md`**](examples/README.md)).
- file **`README.md`** is the [Markdown][github_markdown] document for this page.
- file [**`RESOURCES.md`**](RESOURCES.md) gathers [Kafka] related informations.
- file [**`setenv.bat`**](setenv.bat) is the batch command for setting up our environment.

<!--
> **:mag_right:** We use [VS Code][microsoft_vscode] with the extension [Markdown Preview Github Styling](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-preview-github-styles) to edit our Markdown files (see article ["Mastering Markdown"](https://guides.github.com/features/mastering-markdown/) from [GitHub Guides][github_guides].
-->

We also define a virtual drive **`K:`** in our working environment in order to reduce/hide the real path of our project directory (see article ["Windows command prompt limitation"][windows_limitation] from Microsoft Support).
> **:mag_right:** We use the Windows external command [**`subst`**][windows_subst] to create virtual drives; for instance:
>
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst">subst</a> K: <a href="https://docs.microsoft.com/en-us/windows/deployment/usmt/usmt-recognized-environment-variables#bkmk-2">%USERPROFILE%</a>\workspace\kafka-examples</b>
> </pre>

In the next section we give a brief description of the [batch files][windows_batch_file] present in this project.

## <span id="commands">Batch commands</span>


We distinguish different sets of batch commands:

1. [**`setenv.bat`**](setenv.bat) &ndash; This batch command makes external tools such as [**`git.exe`**][git_userguide] and [**`gradle.bat`**][gradle_cli] directly available from the Windows command prompt (see section [**Project dependencies**](#proj_deps)).

   <pre style="font-size:80%;">
   <b>&gt; <a href="./setenv.bat">setenv</a> -verbose</b>
    Tool versions:
      java 17.0.6, javac 17.0.6, scalac 2.13.10,
      gradle 7.6, mvn 3.8.7,
      git 2.39.1.windows.1, diff 3.8, bash 5.2.12(1)-release
    Tool paths:
      C:\opt\jdk-temurin-17.0.6_10\bin\java.exe
      C:\opt\jdk-temurin-17.0.6_10\bin\javac.exe
      C:\opt\scala-2.13.10\bin\scalac.bat
      C:\opt\gradle-7.6\bin\gradle.bat
      C:\opt\apache-maven-3.8.7\bin\mvn.cmd
      C:\opt\Git-2.39.1\bin\git.exe
      C:\opt\Git-2.39.1\usr\bin\diff.exe
      C:\opt\Git-2.39.1\bin\bash.exe
    Environment variables:
      "GIT_HOME=C:\opt\Git-2.39.1"
      "GRADLE_HOME=C:\opt\gradle-7.6"
      "JAVA_HOME=C:\opt\jdk-temurin-17.0.6_10"
      "KAFKA_HOME=C:\opt\kafka_2.13-3.3.2"
      "MAVEN_HOME=C:\opt\apache-maven-3.8.7"
      "SCALA_HOME=C:\opt\scala-2.13.10"
   &nbsp;
   <b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/where">where</a> git gradle</b>
    C:\opt\Git-2.39.1\bin\git.exe
    C:\opt\Git-2.39.1\mingw64\bin\git.exe
    C:\opt\gradle-7.6\bin\gradle
    C:\opt\gradle-7.6\bin\gradle.bat
   </pre>


## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> ***Java compatibility*** [↩](#anchor_01)

<dl><dd>
<a href="https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=181308223" rel="external"><b>KIP-750</b></a>: Java 8 support is deprecating in Apache Kafka 3.0 and will be dropped in Apache Kafka 4.0.
</dd></dl>

<span id="footnote_021">[2]</span> ***Downloads*** [↩](#anchor_02)

<dl><dd>
In our case we downloaded the following installation files (<a href="#proj_deps">see section 1</a>):
</dd>
<dd>
<pre style="font-size:80%;">
<a href="https://maven.apache.org/download.cgi">apache-maven-3.8.7-bin.zip</a>                         <i>(10 MB)</i>
<a href="https://kafka.apache.org/downloads">kafka_2.13-3.3.2.tgz</a>                               <i>(82 MB)</i>
<a href="https://www.kafkatool.com/download.html" rel="external">offsetexplorer_64bit.exe</a>                           <i>(37 MB)</i>
<a href="https://adoptium.net/releases.html?variant=openjdk11&jvmVariant=hotspot">OpenJDK11U-jdk_x64_windows_hotspot_11.0.18_10.zip</a>  <i>(99 MB)</i>
<a href="https://adoptium.net/releases.html?variant=openjdk17&jvmVariant=hotspot">OpenJDK17U-jdk_x64_windows_hotspot_17.0.6_10.zip</a>   <i>(99 MB)</i>
<a href="https://git-scm.com/download/win">PortableGit-2.39.1-64-bit.7z.exe</a>                   <i>(41 MB)</i>
<a href="https://github.com/sbt/sbt/releases">sbt-1.6.1.zip</a>                                      <i>(17 MB)</i>
<a href="https://www.scala-lang.org/files/archive/">scala-2.13.10.zip</a>                                  <i>(21 MB)</i>
</pre>
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/January 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples
[akka_examples]: https://github.com/michelou/akka-examples
[dart_examples]: https://github.com/michelou/dart-examples
[deno_examples]: https://github.com/michelou/deno-examples
[flix_examples]: https://github.com/michelou/flix-examples
[git_bash]: https://www.atlassian.com/git/tutorials/git-bash
[git_cli]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[git_releases]: https://git-scm.com/download/win
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.39.1.txt
[git_userguide]: https://git-scm.com/docs/git
[github_markdown]: https://github.github.com/gfm/
[golang_examples]: https://github.com/michelou/golang-examples
[graalvm_examples]: https://github.com/michelou/graalvm-examples
[gradle_cli]: https://docs.gradle.org/current/userguide/command_line_interface.html
[haskell_examples]: https://github.com/michelou/haskell-examples
[kafka]: https://kafka.apache.org
[kafka_downloads]: https://kafka.apache.org/downloads
[kafka_relnotes]: https://downloads.apache.org/kafka/3.3.2/RELEASE_NOTES.html
[kafkatool_changes]: https://www.kafkatool.com/changes.html
[kafkatool_downloads]: https://www.kafkatool.com/download.html
[kotlin_examples]: https://github.com/michelou/kotlin-examples
[llvm_examples]: https://github.com/michelou/llvm-examples
[man1_awk]: https://www.linux.org/docs/man1/awk.html
[man1_diff]: https://www.linux.org/docs/man1/diff.html
[man1_file]: https://www.linux.org/docs/man1/file.html
[man1_grep]: https://www.linux.org/docs/man1/grep.html
[man1_more]: https://www.linux.org/docs/man1/more.html
[man1_mv]: https://www.linux.org/docs/man1/mv.html
[man1_rmdir]: https://www.linux.org/docs/man1/rmdir.html
[man1_sed]: https://www.linux.org/docs/man1/sed.html
[man1_wc]: https://www.linux.org/docs/man1/wc.html
[nodejs_examples]: https://github.com/michelou/nodejs-examples
[rust_examples]: https://github.com/michelou/rust-examples
[scala3_examples]: https://github.com/michelou/dotty-examples
[spark_examples]: https://github.com/michelou/spark-examples
[spring_examples]: https://github.com/michelou/spring-examples
[temurin_opendjk11_bugfixes]: https://www.oracle.com/java/technologies/javase/11-0-17-bugfixes.html
[temurin_opendjk11_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-October/018119.html
[temurin_opendjk11]: https://adoptium.net/releases.html?variant=openjdk11&jvmVariant=hotspot
[temurin_opendjk17]: https://adoptium.net/releases.html?variant=openjdk17&jvmVariant=hotspot
[temurin_opendjk17_bugfixes]: https://www.oracle.com/java/technologies/javase/17-0-2-bugfixes.html
[temurin_opendjk17_relnotes]: https://github.com/openjdk/jdk/compare/jdk-17%2B20...jdk-17%2B21
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples
[unix_bash_script]: https://www.gnu.org/software/bash/manual/bash.html
[unix_opt]: https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/opt.html
[windows_batch_file]: https://en.wikibooks.org/wiki/Windows_Batch_Scripting
[windows_installer]: https://docs.microsoft.com/en-us/windows/win32/msi/windows-installer-portal
[windows_limitation]: https://support.microsoft.com/en-gb/help/830473/command-prompt-cmd-exe-command-line-string-limitation
[windows_subst]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst
[wix_examples]: https://github.com/michelou/wix-examples
[zip_archive]: https://www.howtogeek.com/178146/htg-explains-everything-you-need-to-know-about-zipped-files/
