# <span id="top">Playing with Kafka on Windows</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;">
    <a href="https://kafka.apache.org/" rel="external"><img style="border:0;width:120px;" src="./docs/images/apache-kafka.png" alt="Kafka project"/></a>
  </td>
  <td style="border:0;padding:0;vertical-align:text-top;">
    This repository gathers <a href="https://kafka.apache.org/" rel="external">Kafka</a> code examples coming from various websites or written by ourself.<br/>
    In particular it includes several build scripts (<a href="https://www.gnu.org/software/bash/manual/bash.html" rel="external">bash scripts</a>, <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a>) for experimenting with the <a href="https://kafka.apache.org" rel="external">Kafka</a> system on a Windows machine.
  </td>
  </tr>
</table>

[Ada][ada_examples], [Akka][akka_examples], [C++][cpp_examples], [COBOL][cobol_examples], [Dart][dart_examples], [Deno][deno_examples], [Docker][docker_examples], [Erlang][erlang_examples], [Flix][flix_examples], [Golang][golang_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Modula-2][m2_examples], [Node.js][nodejs_examples], [Rust][rust_examples], [Scala 3][scala3_examples], [Spark][spark_examples], [Spring][spring_examples], [TruffleSqueak][trufflesqueak_examples], [WiX Toolset][wix_examples] and [Zig][zig_examples] are other topics we are continuously monitoring.

> **&#9755;** Read the document <a href="https://kafka.apache.org/documentation/#gettingStarted">"Getting Started"</a> from the <a href="https://kafka.apache.org/" rel="external">Kafka</a> documentation to know more about the <a href="https://kafka.apache.org/" rel="external">Kafka</a> ecosystem.

## <span id="proj_deps">Project dependencies</span> [**&#x25B4;**](#top)

This project depends on the following external software for the **Microsoft Windows** platform:

- [Git 2.45][git_releases] ([*release notes*][git_relnotes])
- [Kafka 3.7][kafka_downloads] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][kafka_relnotes])
- [Temurin OpenJDK 17 LTS][temurin_openjdk17] <sup id="anchor_02">[2](#footnote_02)</sup> ([*release notes*][temurin_openjdk17_relnotes], [*bug fixes*][temurin_openjdk17_bugfixes])

Optionally one may also install the following software:

- [Apache Maven 3.9][apache_maven] ([requires Java 8+][apache_maven_history])  ([*release notes*][apache_maven_relnotes])
- [ConEmu][conemu_downloads] ([*release notes*][conemu_relnotes])
- [Gradle 8.8][gradle_install] ([requires Java 8+][gradle_compatibility]) ([*release notes*][gradle_relnotes])
- [Offset Explorer 3.0][kafkatool_downloads] <sup id="anchor_03">[3](#footnote_03)</sup> ([*change history*][kafkatool_changes])
- [Scala 2.13][scala_releases] (requires Java 8+) ([*release notes*][scala_relnotes], [*Scala API*][scala_api])
- [Temurin OpenJDK 11 LTS][temurin_openjdk11] ([*release notes*][temurin_openjdk11_relnotes], [*bug fixes*][temurin_openjdk11_bugfixes])
- [Temurin OpenJDK 21 LTS][temurin_openjdk21] ([*release notes*][temurin_openjdk21_relnotes], [*Java 21 API*][oracle_openjdk21_api])
- [Visual Studio Code 1.90][vscode_downloads] ([*release notes*][vscode_relnotes])

> **&#9755;** ***Installation policy***<br/>
> When possible we install software from a [Zip archive][zip_archive] rather than via a [Windows installer][windows_installer]. In our case we defined **`C:\opt\`** as the installation directory for optional software tools (*in reference to* the [`/opt/`][unix_opt] directory on Unix).

For instance our development environment looks as follows (*June 2024*) <sup id="anchor_04">[4](#footnote_04)</sup>:

<pre style="font-size:80%;">
C:\opt\apache-maven\               <i>( 10 MB)</i>
C:\opt\ConEmu\                     <i>( 26 MB)</i>
C:\opt\Git\                        <i>(387 MB)</i>
C:\opt\gradle\                     <i>(135 MB)</i>
C:\opt\jdk-temurin-11.0.23_9\      <i>(302 MB)</i>
C:\opt\jdk-temurin-17.0.11_9\      <i>(301 MB)</i>
C:\opt\jdk-temurin-21.0.3_9\       <i>(325 MB)</i>
C:\opt\kafka_2.13-3.7.0\           <i>(118 MB)</i>
C:\opt\scala-2.13.14\              <i>( 24 MB)</i>
C:\opt\VSCode\                     <i>(341 MB)</i>
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

We also define a virtual drive &ndash; e.g. drive **`K:`** &ndash; in our working environment in order to reduce/hide the real path of our project directory (see article ["Windows command prompt limitation"][windows_limitation] from Microsoft Support).
> **:mag_right:** We use the Windows external command [**`subst`**][windows_subst] to create virtual drives; for instance:
>
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst">subst</a> K: <a href="https://docs.microsoft.com/en-us/windows/deployment/usmt/usmt-recognized-environment-variables#bkmk-2">%USERPROFILE%</a>\workspace\kafka-examples</b>
> </pre>

In the next section we give a brief description of the [batch files][windows_batch_file] present in this project.

## <span id="commands">Batch commands</span> [**&#x25B4;**](#top)

### [**`setenv.bat`**](setenv.bat)

We execute command [**`setenv.bat`**](setenv.bat) once to setup our development environment; it makes external tools such as [**`git.exe`**][git_userguide], [**`gradle.bat`**][gradle_cli] and [**`sh.exe`**][sh_cli] directly available from the Windows command prompt (see section [**Project dependencies**](#proj_deps)).

   <pre style="font-size:80%;">
   <b>&gt; <a href="./setenv.bat">setenv</a> -verbose</b>
    Tool versions:
      java 17.0.11, javac 17.0.11, scalac 2.13.14,
      gradle 8.8, kafka-configs 3.7.0, mvn 3.9.7,
      git 2.45.2, diff 3.10, bash 5.2.26(1)-release
    Tool paths:
      C:\opt\jdk-temurin-17.0.11_9\bin\java.exe
      C:\opt\jdk-temurin-17.0.11_9\bin\javac.exe
      C:\opt\scala-2.13.14\bin\scalac.bat
      C:\opt\gradle\bin\gradle.bat
      C:\opt\kafka_2.13-3.7.0\bin\windows\kafka-configs.bat
      C:\opt\apache-maven\bin\mvn.cmd
      C:\opt\Git\bin\git.exe
      C:\opt\Git\usr\bin\diff.exe
      C:\opt\Git\bin\bash.exe
    Environment variables:
      "GIT_HOME=C:\opt\Git"
      "GRADLE_HOME=C:\opt\gradle"
      "JAVA_HOME=C:\opt\jdk-temurin-17.0.11_9"
      "KAFKA_HOME=C:\opt\kafka_2.13-3.7.0"
      "MAVEN_HOME=C:\opt\apache-maven"
      "SCALA_HOME=C:\opt\scala-2.13.14"
   &nbsp;
   <b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/where">where</a> git gradle</b>
    C:\opt\Git\bin\git.exe
    C:\opt\Git\mingw64\bin\git.exe
    C:\opt\gradle\bin\gradle
    C:\opt\gradle\bin\gradle.bat
    C:\opt\Git\bin\sh.exe
    C:\opt\Git\usr\bin\sh.exe
   </pre>


## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> ***Kafka components*** [↩](#anchor_01)

<dl><dd>
<table>
<tr>
<th><a href="https://kafka.apache.org/" rel="external">Kakfa</a></th>
<th><a href="https://zookeeper.apache.org/releases.html" rel="external">ZooKeeper</a></th>
<th><a href="https://www.eclipse.org/jetty/" rel="external">Jetty</a></th>
<th>Java</th>
</tr>
<tr>
<td><a href="https://downloads.apache.org/kafka/3.7.0/RELEASE_NOTES.html">3.7.0</a></td>
<td><a href="https://zookeeper.apache.org/doc/r3.8.3/releasenotes.html">3.8.3</a></td>
<td><a href="https://github.com/jetty/jetty.project/releases/tag/jetty-9.4.54.v20240208">9.4.54</a> <sup><b>b)</b></sup></td>
<td>8+</td>
</tr>
<tr>
<td><a href="https://archive.apache.org/dist/kafka/3.6.2/RELEASE_NOTES.html">3.6.2</a></td>
<td><a href="https://zookeeper.apache.org/doc/r3.8.4/releasenotes.html">3.8.4</a> <sup><b>a)</b></sup</td>
<td></td>
<td>8+</td>
</tr>
<tr>
<td><a href="https://archive.apache.org/dist/kafka/3.6.1/RELEASE_NOTES.html">3.6.1</a></td>
<td><a href="https://zookeeper.apache.org/doc/r3.8.3/releasenotes.html">3.8.3</a></td>
<td><a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-9.4.53.v20230217">9.4.53</a> <sup><b>b)</b></sup></td>
<td>8+</td>
</tr>
<tr>
<td><a href="https://archive.apache.org/dist/kafka/3.6.0/RELEASE_NOTES.html">3.6.0</a></td>
<td><a href="https://zookeeper.apache.org/doc/r3.8.2/releasenotes.html">3.8.2</a></td>
<td><a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-9.4.52.v20230217">9.4.52</a></td>
<td>8+</td>
</tr>
<tr>
<td><a href="https://archive.apache.org/dist/kafka/3.5.1/RELEASE_NOTES.html">3.5.1</a></td>
<td><a href="https://zookeeper.apache.org/doc/r3.6.4/releasenotes.html">3.6.4</a></td>
<td><a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-9.4.51.v20230217">9.4.51</a></td>
<td>8+</td>
</tr>
<tr>
<td><a href="https://archive.apache.org/dist/kafka/3.5.0/RELEASE_NOTES.htmll">3.5.0</a></td>
<td><a href="https://zookeeper.apache.org/doc/r3.6.4/releasenotes.html">3.6.4</a></td>
<td><a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-9.4.51.v20230217">9.4.51</a></td>
<td>8+</td>
</tr>
<tr>
<td><a href="https://archive.apache.org/dist/kafka/3.4.1/RELEASE_NOTES.html">3.4.1</a></td><td><a href="https://zookeeper.apache.org/doc/r3.6.4/releasenotes.html">3.6.4</a></td><td><a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-9.4.51.v20230217">9.4.51</a></td><td>8+</td>
</tr>
<tr>
<td><a href="https://archive.apache.org/dist/kafka/3.4.0/RELEASE_NOTES.html">3.4.0</a></td><td><a href="https://zookeeper.apache.org/doc/r3.6.3/releasenotes.html">3.6.3</a></td><td><a href="https://github.com/eclipse/jetty.project/releases/tag/jetty-9.4.48.v20220622">9.4.48</a></td><td>8+</td></tr>
<tr><td><a href="https://archive.apache.org/dist/kafka/3.3.0/RELEASE_NOTES.html">3.3.x</a></td><td><a href="https://zookeeper.apache.org/doc/r3.6.3/releasenotes.html">3.6.3</a></td><td>?</td><td>?</td>
</tr>
<tr>
<td><a href="https://archive.apache.org/dist/kafka/3.2.0/RELEASE_NOTES.html">3.2.x</a></td>
<td><a href="https://zookeeper.apache.org/doc/r3.6.3/releasenotes.html">3.6.3</a></td>
<td>?</td>
<td>?</td>
</tr>
</table>
<span><sup><b>a)</b></sup> ZooKeeper current stable version is <a href="https://zookeeper.apache.org/releases.html"><b>3.9.2</b></a> as of March 11, 2024 (<a href="https://mvnrepository.com/artifact/org.apache.zookeeper/zookeeper">MVN Repository</a>).<br/>
<sup><b>b)</b></sup> Jetty current version is <a href="https://github.com/jetty/jetty.project/releases/tag/jetty-12.0.8"><b>12.0.8</b></a> as of January 31, 2024 (<a href="https://mvnrepository.com/artifact/org.eclipse.jetty/jetty-server">MVN Repository</a>).<br/>
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
  <li>The browser tree allows us to easily view and navigate the objects (brokers, topices, particitions, consumers) in our <a href="https://www.confluent.io/blog/what-is-an-apache-kafka-cluster/">Apache Kafka cluster</a>.</li>
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
<a href="https://maven.apache.org/download.cgi">apache-maven-3.9.7-bin.zip</a>                         <i>( 10 MB)</i>
<a href="https://github.com/Maximus5/ConEmu/releases/tag/v23.07.24" rel="external">ConEmuPack.230724.7z</a>                               <i>(  5 MB)</i>
<a href="https://gradle.org/install/">gradle-8.8-bin.zip</a>                                 <i>(118 MB)</i>
<a href="https://kafka.apache.org/downloads">kafka_2.13-3.7.0.tgz</a>                               <i>( 82 MB)</i>
<a href="https://www.kafkatool.com/download.html" rel="external">offsetexplorer_64bit.exe</a>                           <i>( 37 MB)</i>
<a href="https://adoptium.net/releases.html?variant=openjdk11&jvmVariant=hotspot">OpenJDK11U-jdk_x64_windows_hotspot_11.0.23_9.zip</a>   <i>( 99 MB)</i>
<a href="https://adoptium.net/releases.html?variant=openjdk17&jvmVariant=hotspot">OpenJDK17U-jdk_x64_windows_hotspot_17.0.11_9.zip</a>   <i>( 99 MB)</i>
<a href="ttps://adoptium.net/releases.html?variant=openjdk21&jvmVariant=hotspot">OpenJDK21U-jdk_x64_windows_hotspot_21.0.3_9.zip</a>    <i>(191 MB)</i>
<a href="https://git-scm.com/download/win">PortableGit-2.45.2-64-bit.7z.exe</a>                   <i>( 41 MB)</i>
<a href="https://www.scala-lang.org/files/archive/" rel="external">scala-2.13.14.zip</a>                                  <i>( 22 MB)</i>
<a href="https://code.visualstudio.com/Download#" rel="external">VSCode-win32-x64-1.90.1.zip</a>                        <i>(131 MB)</i>
</pre>
</dd></dl>
<!--
<a href="https://github.com/sbt/sbt/releases">sbt-1.9.7.zip</a>                                      <i>( 17 MB)</i>
<a href="https://www.scala-lang.org/files/archive/">scala-2.13.14.zip</a>                                  <i>( 21 MB)</i>
-->

***

*[mics](https://lampwww.epfl.ch/~michelou/)/June 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples#top
[akka_examples]: https://github.com/michelou/akka-examples#top
[apache_maven]: https://maven.apache.org/download.cgi
[apache_maven_history]: https://maven.apache.org/docs/history.html
[apache_maven_relnotes]: https://maven.apache.org/docs/3.9.7/release-notes.html
[cobol_examples]: https://github.com/michelou/cobol-examples#top
[conemu_downloads]: https://github.com/Maximus5/ConEmu/releases
[conemu_relnotes]: https://conemu.github.io/blog/2023/07/24/Build-230724.html
[cpp_examples]: https://github.com/michelou/cpp-examples#top
[dart_examples]: https://github.com/michelou/dart-examples#top
[deno_examples]: https://github.com/michelou/deno-examples#top
[docker_examples]: https://github.com/michelou/docker-examples#top
[erlang_examples]: https://github.com/michelou/erlang-examples#top
[flix_examples]: https://github.com/michelou/flix-examples#top
[git_bash]: https://www.atlassian.com/git/tutorials/git-bash
[git_cli]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[git_releases]: https://git-scm.com/download/win
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.45.2.txt
[git_userguide]: https://git-scm.com/docs/git
[github_markdown]: https://github.github.com/gfm/
[golang_examples]: https://github.com/michelou/golang-examples#top
[graalvm_examples]: https://github.com/michelou/graalvm-examples#top
[gradle_cli]: https://docs.gradle.org/current/userguide/command_line_interface.html
[gradle_compatibility]: https://docs.gradle.org/current/release-notes.html#upgrade-instructions
[gradle_install]: https://gradle.org/install/
[gradle_relnotes]: https://docs.gradle.org/8.8/release-notes.html
[haskell_examples]: https://github.com/michelou/haskell-examples#top
[kafka]: https://kafka.apache.org
[kafka_downloads]: https://kafka.apache.org/downloads
<!--
3.4.0 -> https://archive.apache.org/dist/kafka/3.4.0/RELEASE_NOTES.html
3.4.1 -> https://archive.apache.org/dist/kafka/3.4.1/RELEASE_NOTES.html
3.5.0 -> https://archive.apache.org/dist/kafka/3.5.0/RELEASE_NOTES.html
3.5.1 -> https://archive.apache.org/dist/kafka/3.5.1/RELEASE_NOTES.html
3.6.0 -> https://archive.apache.org/dist/kafka/3.6.0/RELEASE_NOTES.html
3.6.1 -> https://archive.apache.org/dist/kafka/3.6.1/RELEASE_NOTES.html
3.7.0 -> https://archive.apache.org/dist/kafka/3.7.0/RELEASE_NOTES.html
-->
[kafka_relnotes]: https://archive.apache.org/dist/kafka/3.7.0/RELEASE_NOTES.html
[kafkatool_changes]: https://www.kafkatool.com/changes.html
[kafkatool_downloads]: https://www.kafkatool.com/download.html
[kotlin_examples]: https://github.com/michelou/kotlin-examples#top
[llvm_examples]: https://github.com/michelou/llvm-examples#top
[m2_examples]: https://github.com/michelou/m2-examples#top
[man1_awk]: https://www.linux.org/docs/man1/awk.html
[man1_diff]: https://www.linux.org/docs/man1/diff.html
[man1_file]: https://www.linux.org/docs/man1/file.html
[man1_grep]: https://www.linux.org/docs/man1/grep.html
[man1_more]: https://www.linux.org/docs/man1/more.html
[man1_mv]: https://www.linux.org/docs/man1/mv.html
[man1_rmdir]: https://www.linux.org/docs/man1/rmdir.html
[man1_sed]: https://www.linux.org/docs/man1/sed.html
[man1_wc]: https://www.linux.org/docs/man1/wc.html
[nodejs_examples]: https://github.com/michelou/nodejs-examples#top
[oracle_openjdk21]: https://jdk.java.net/21/
[oracle_openjdk21_api]: https://download.java.net/java/early_access/jdk21/docs/api/
[oracle_openjdk21_relnotes]: https://jdk.java.net/21/release-notes
[rust_examples]: https://github.com/michelou/rust-examples#top
[scala_api]: https://www.scala-lang.org/files/archive/api/current/
[scala_releases]: https://www.scala-lang.org/files/archive/
[scala_relnotes]: https://github.com/scala/scala/releases/tag/v2.13.14
[scala3_examples]: https://github.com/michelou/dotty-examples#top
[sh_cli]: https://man7.org/linux/man-pages/man1/sh.1p.html
[spark_examples]: https://github.com/michelou/spark-examples#top
[spring_examples]: https://github.com/michelou/spring-examples#top
<!--
#### Archives ### https://mail.openjdk.org/pipermail/jdk-updates-dev/
11.0.3  -> https://mail.openjdk.java.net/pipermail/jdk-updates-dev/2019-April/000951.html
11.0.4  -> https://mail.openjdk.java.net/pipermail/jdk-updates-dev/2019-July/001423.html
11.0.5  -> https://mail.openjdk.java.net/pipermail/jdk-updates-dev/2019-October/002025.html
11.0.6  -> https://mail.openjdk.java.net/pipermail/jdk-updates-dev/2020-January/002374.html
11.0.7  -> https://mail.openjdk.java.net/pipermail/jdk-updates-dev/2020-April/003019.html
11.0.8  -> https://mail.openjdk.java.net/pipermail/jdk-updates-dev/2020-July/003498.html
11.0.9  -> https://mail.openjdk.java.net/pipermail/jdk-updates-dev/2020-October/004007.html
11.0.10 -> https://mail.openjdk.java.net/pipermail/jdk-updates-dev/2021-January/004689.html
11.0.11 -> https://mail.openjdk.java.net/pipermail/jdk-updates-dev/2021-April/005860.html
11.0.12 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2021-July/006954.html
11.0.13 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2021-October/009368.html
11.0.14 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-January/011643.html
11.0.15 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-April/014104.html
11.0.16 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-July/016017.html
11.0.17 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-October/018119.html
11.0.18 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-January/020111.html
11.0.19 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-April/021900.html
11.0.20 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-July/024064.html
11.0.21 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026351.html
11.0.22 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-January/029215.html
-->
[temurin_openjdk11]: https://adoptium.net/releases.html?variant=openjdk11&jvmVariant=hotspot
[temurin_openjdk11_bugfixes]: https://www.oracle.com/java/technologies/javase/11-0-21-bugfixes.html
[temurin_openjdk11_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026351.html
<!--
17.0.2  -> https://www.oracle.com/java/technologies/javase/17-0-2-bugfixes.html
17.0.3  -> https://www.oracle.com/java/technologies/javase/17-0-3-bugfixes.html
17.0.7  -> https://www.oracle.com/java/technologies/javase/17-0-7-relnotes.html
17.0.8  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-September/025526.html
17.0.9  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026352.html
17.0.10 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-January/029089.html
17.0.11 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-April/032197.html
-->
[temurin_openjdk17]: https://adoptium.net/releases.html?variant=openjdk17&jvmVariant=hotspot
[temurin_openjdk17_bugfixes]: https://www.oracle.com/java/technologies/javase/17-0-9-relnotes.html
[temurin_openjdk17_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026352.html
<!--
21_35   -> https://adoptium.net/fr/temurin/release-notes/?version=jdk-21+35
21.0.1  -> https://www.oracle.com/java/technologies/javase/21-0-1-relnotes.html
21.0.2  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-January/029090.html
21.0.3  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-April/032196.html
-->
[temurin_openjdk21]: https://adoptium.net/fr/temurin/releases/?variant=openjdk21&jvmVariant=hotspot
[temurin_openjdk21_relnotes]: https://adoptium.net/fr/temurin/release-notes/?version=jdk-21+35
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples#top
[unix_bash_script]: https://www.gnu.org/software/bash/manual/bash.html
[unix_opt]: https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/opt.html
[vscode_downloads]: https://code.visualstudio.com/#alt-downloads
[vscode_relnotes]: https://code.visualstudio.com/updates/
[windows_batch_file]: https://en.wikibooks.org/wiki/Windows_Batch_Scripting
[windows_installer]: https://docs.microsoft.com/en-us/windows/win32/msi/windows-installer-portal
[windows_limitation]: https://support.microsoft.com/en-gb/help/830473/command-prompt-cmd-exe-command-line-string-limitation
[windows_subst]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst
[wix_examples]: https://github.com/michelou/wix-examples#top
[zig_examples]: https://github.com/michelou/zig-examples#top
[zip_archive]: https://www.howtogeek.com/178146/htg-explains-everything-you-need-to-know-about-zipped-files/
