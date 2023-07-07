# <span id="top">Playing with Kafka on Windows</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;">
    <a href="https://kafka.apache.org/" rel="external"><img style="border:0;width:120px;" src="./docs/images/apache-kafka.png" alt="Kafka project"/></a>
  </td>
  <td style="border:0;padding:0;vertical-align:text-top;">
    This repository gathers <a href="https://kafka.apache.org/" rel="external">Kafka</a> code examples coming from various websites or written by myself.<br/>
    In particular it includes several build scripts (<a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a>, <a href="https://www.gnu.org/software/bash/manual/bash.html" rel="external">bash scripts</a>) for experimenting with the <a href="https://kafka.apache.org" rel="external">Kafka</a> system on a Windows machine.
  </td>
  </tr>
</table>

> **&#9755;** Read the document <a href="https://kafka.apache.org/documentation/#gettingStarted">"Getting Started"</a> from the <a href="https://kafka.apache.org/" rel="external">Kafka</a> documentation to know more about the <a href="https://kafka.apache.org/" rel="external">Kafka</a> ecosystem. 

[Ada][ada_examples], [Akka][akka_examples], [Dart][dart_examples], [Deno][deno_examples], [Flix][flix_examples], [Golang][golang_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Node.js][nodejs_examples], [Rust][rust_examples], [Scala 3][scala3_examples], [Spark][spark_examples], [Spring][spring_examples], [TruffleSqueak][trufflesqueak_examples] and [WiX Toolset][wix_examples] are other trending topics we are continuously monitoring.

## <span id="proj_deps">Project dependencies</span>

This project depends on the following external software for the **Microsoft Windows** platform:

- [Git 2.41][git_releases] ([*release notes*][git_relnotes])
- [Kafka 3.5][kafka_downloads] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][kafka_relnotes])
- [Temurin OpenJDK 17 LTS][temurin_opendjk17] <sup id="anchor_02">[2](#footnote_02)</sup> ([*release notes*][temurin_opendjk17_relnotes], [*bug fixes*][temurin_opendjk17_bugfixes])

Optionally one may also install the following software:

- [Apache Maven 3.9][apache_maven] ([requires Java 8 or newer][apache_maven_history])  ([*release notes*][apache_maven_relnotes])
- [Gradle 8.1][gradle_install] ([requires Java 8 or newer][gradle_compatibility]) ([*release notes*][gradle_relnotes])
- [Offset Explorer 2.3][kafkatool_downloads] <sup id="anchor_03">[3](#footnote_03)</sup> ([*change history*][kafkatool_changes])
- [Temurin OpenJDK 11 LTS][temurin_opendjk11] ([*release notes*][temurin_opendjk11_relnotes], [*bug fixes*][temurin_opendjk11_bugfixes])

> **&#9755;** ***Installation policy***<br/>
> When possible we install software from a [Zip archive][zip_archive] rather than via a [Windows installer][windows_installer]. In our case we defined **`C:\opt\`** as the installation directory for optional software tools (*in reference to* the [`/opt/`][unix_opt] directory on Unix).

For instance our development environment looks as follows (*July 2023*) <sup id="anchor_04">[4](#footnote_04)</sup>:

<pre style="font-size:80%;">
C:\opt\apache-maven-3.9.3\         <i>( 10 MB)</i>
C:\opt\Git-2.41.0\                 <i>(315 MB)</i>
C:\opt\gradle-8.2\                 <i>(129 MB)</i>
C:\opt\jdk-temurin-11.0.19_7\      <i>(302 MB)</i>
C:\opt\jdk-temurin-17.0.7_7\       <i>(299 MB)</i>
C:\opt\kafka_2.13-3.5.0\           <i>(105 MB)</i>
C:\opt\scala-2.13.11\              <i>( 23 MB)</i>
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
      java 17.0.7, javac 17.0.7, scalac 2.13.11,
      gradle 8.2, kafka-configs 3.5.0, mvn 3.9.3,
      git 2.41.0.windows.1, diff 3.9, bash 5.2.12(1)-release
    Tool paths:
      C:\opt\jdk-temurin-17.0.6_10\bin\java.exe
      C:\opt\jdk-temurin-17.0.6_10\bin\javac.exe
      C:\opt\scala-2.13.11\bin\scalac.bat
      C:\opt\gradle-8.2\bin\gradle.bat
      C:\opt\kafka_2.13-3.5.0\bin\windows\kafka-configs.bat
      C:\opt\apache-maven-3.9.3\bin\mvn.cmd
      C:\opt\Git-2.41.0\bin\git.exe
      C:\opt\Git-2.41.0\usr\bin\diff.exe
      C:\opt\Git-2.41.0\bin\bash.exe
    Environment variables:
      "GIT_HOME=C:\opt\Git-2.41.0"
      "GRADLE_HOME=C:\opt\gradle-8.2"
      "JAVA_HOME=C:\opt\jdk-temurin-17.0.7_7"
      "KAFKA_HOME=C:\opt\kafka_2.13-3.5.0"
      "MAVEN_HOME=C:\opt\apache-maven-3.9.3"
      "SCALA_HOME=C:\opt\scala-2.13.11"
   &nbsp;
   <b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/where">where</a> git gradle</b>
    C:\opt\Git-2.41.0\bin\git.exe
    C:\opt\Git-2.41.0\mingw64\bin\git.exe
    C:\opt\gradle-8.2\bin\gradle
    C:\opt\gradle-8.2\bin\gradle.bat
   </pre>


## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)


<span id="footnote_01">[1]</span> ***Kafka components*** [↩](#anchor_01)

<dl><dd>
<table>
<tr><th><a href="https://kafka.apache.org/">Kakfa</a></th><th>ZooKeeper</th><th><a href="https://www.eclipse.org/jetty/">Jetty</a></th></tr>
<tr><td><a href="https://downloads.apache.org/kafka/3.5.0/RELEASE_NOTES.html">3.5.0</a></td><td><a href="https://zookeeper.apache.org/doc/r3.6.4/releasenotes.html">3.6.4</a> <sup><b>a)</b></sup></td><td><a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-9.4.51.v20230217">9.4.51</a> <sup><b>b)</b></sup></td></tr>
<tr><td><a href="https://archive.apache.org/dist/kafka/3.4.1/RELEASE_NOTES.html">3.4.1</a></td><td><a href="https://zookeeper.apache.org/doc/r3.6.4/releasenotes.html">3.6.4</a></td><td><a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-9.4.51.v20230217">9.4.51</a></td></tr>
<tr><td><a href="https://archive.apache.org/dist/kafka/3.4.0/RELEASE_NOTES.html">3.4.0</a></td><td><a href="https://zookeeper.apache.org/doc/r3.6.3/releasenotes.html">3.6.3</a></td><td><a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-9.4.48.v20220622">9.4.48</a> <sup><b>c)</b></sup></td></tr>
<tr><td><a href="https://archive.apache.org/dist/kafka/3.3.0/RELEASE_NOTES.html">3.3.x</a></td><td><a href="https://zookeeper.apache.org/doc/r3.6.3/releasenotes.html">3.6.3</a></td><td>?</td></tr>
<tr><td><a href="https://archive.apache.org/dist/kafka/3.2.0/RELEASE_NOTES.html">3.2.x</a></td><td><a href="https://zookeeper.apache.org/doc/r3.6.3/releasenotes.html">3.6.3</a></td><td>?</td></tr>
</table>
<span><sup><b>a)</b></sup> ZooKeeper current version is <a href="https://zookeeper.apache.org/doc/r3.8.1/"><b>3.8.1</b></a> as of January 30, 2023 (<a href="https://mvnrepository.com/artifact/org.apache.zookeeper/zookeeper">MVN Repository</a>).<br/>
<sup><b>b)</b></sup> Jetty current version is <a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-11.0.15"><b>11.0.15</b></a> as of April 13, 2023 (<a href="https://mvnrepository.com/artifact/org.eclipse.jetty/jetty-server">MVN Repository</a>).<br/>
<sup><b>c)</b></sup> Jetty 9.4.x is at End of Community Support as of June 1, 2023 (<a href="https://github.com/eclipse/jetty.project/issues/7958">#7958</a>).
</span>
</dd></dl>

<span id="footnote_02">[2]</span> ***Java compatibility*** [↩](#anchor_02)

<dl><dd>
<a href="https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=181308223" rel="external"><b>KIP-750</b></a>: Java 8 support is deprecating in Apache Kafka 3.0 and will be dropped in Apache Kafka 4.0.
</dd></dl>

<span id="footnote_03">[3]</span> ***Offset Explorer*** [↩](#anchor_03)

<dl><dd>
<a href="https://www.kafkatool.com/features.html" rel="external"><b>Offset Explorer</b></a> (formerly named <b>Kalfa Tool</b>) provides the following features :
<ul>
  <li>The browser tree allows us to easily view and navigate the objects (brokers, topices, particitions, consumers) in our Apache Kafka cluster.</li>
  <li>The explorer allows us to view messages (and their keys) in the partitions of the topics we are interested in.</li>
  <li>If the string-based data is either in JSON or XML format, we can view it in a pretty-printed manner.</li>
  <li>The browser tree also allows us to quickly view all offsets of our <a href="https://kafka.apache.org">Kafka</a> consumers.</li>
</ul>
</dd></dl>

<span id="footnote_04">[4]</span> ***Downloads*** [↩](#anchor_04)

<dl><dd>
In our case we downloaded the following installation files (<a href="#proj_deps">see section 1</a>):
</dd>
<dd>
<pre style="font-size:80%;">
<a href="https://maven.apache.org/download.cgi">apache-maven-3.9.3-bin.zip</a>                         <i>( 10 MB)</i>
<a href="https://gradle.org/install/">gradle-8.2-bin.zip</a>                                 <i>(118 MB)</i>
<a href="https://kafka.apache.org/downloads">kafka_2.13-3.5.0.tgz</a>                               <i>( 82 MB)</i>
<a href="https://www.kafkatool.com/download.html" rel="external">offsetexplorer_64bit.exe</a>                           <i>( 37 MB)</i>
<a href="https://adoptium.net/releases.html?variant=openjdk11&jvmVariant=hotspot">OpenJDK11U-jdk_x64_windows_hotspot_11.0.19_7.zip</a>   <i>( 99 MB)</i>
<a href="https://adoptium.net/releases.html?variant=openjdk17&jvmVariant=hotspot">OpenJDK17U-jdk_x64_windows_hotspot_17.0.7_7.zip</a>    <i>( 99 MB)</i>
<a href="https://git-scm.com/download/win">PortableGit-2.41.0-64-bit.7z.exe</a>                   <i>( 41 MB)</i>
</pre>
</dd></dl>
<!--
<a href="https://github.com/sbt/sbt/releases">sbt-1.9.0.zip</a>                                      <i>( 17 MB)</i>
<a href="https://www.scala-lang.org/files/archive/">scala-2.13.11.zip</a>                                  <i>( 21 MB)</i>
-->

***

*[mics](https://lampwww.epfl.ch/~michelou/)/July 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples
[akka_examples]: https://github.com/michelou/akka-examples
[apache_maven]: https://maven.apache.org/download.cgi
[apache_maven_history]: https://maven.apache.org/docs/history.html
[apache_maven_relnotes]: https://maven.apache.org/docs/3.9.3/release-notes.html
[dart_examples]: https://github.com/michelou/dart-examples
[deno_examples]: https://github.com/michelou/deno-examples
[flix_examples]: https://github.com/michelou/flix-examples
[git_bash]: https://www.atlassian.com/git/tutorials/git-bash
[git_cli]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[git_releases]: https://git-scm.com/download/win
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.41.0.txt
[git_userguide]: https://git-scm.com/docs/git
[github_markdown]: https://github.github.com/gfm/
[golang_examples]: https://github.com/michelou/golang-examples
[graalvm_examples]: https://github.com/michelou/graalvm-examples
[gradle_cli]: https://docs.gradle.org/current/userguide/command_line_interface.html
[gradle_compatibility]: https://docs.gradle.org/current/release-notes.html#upgrade-instructions
[gradle_install]: https://gradle.org/install/
[gradle_relnotes]: https://docs.gradle.org/8.1/release-notes.html
[haskell_examples]: https://github.com/michelou/haskell-examples
[kafka]: https://kafka.apache.org
[kafka_downloads]: https://kafka.apache.org/downloads
<!--
3.4.0 -> https://archive.apache.org/dist/kafka/3.4.0/RELEASE_NOTES.html
3.4.1 -> https://archive.apache.org/dist/kafka/3.4.1/RELEASE_NOTES.html
3.5.0 -> https://archive.apache.org/dist/kafka/3.5.0/RELEASE_NOTES.html
-->
[kafka_relnotes]: https://archive.apache.org/dist/kafka/3.5.0/RELEASE_NOTES.html
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
