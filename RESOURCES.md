# <span id="top">Kafka Resources</span> <span style="size:30%;"><a href="README.md">↩</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://kafka.apache.org/"><img src="./docs/images/apache-kafka.png" width="100" alt="Kafka project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document gathers <a href="https://kafka.apache.org/" rel="external">Kafka</a> related resources we have collected so far.
  </td>
  </tr>
</table>

## <span id="articles">Articles</span>

- [Apache Kafka Architecture: A Complete Guide][article_carter] by Michael Carter, June 2020.

## <span id="blogs">Blogs</span>

- [Remote code execution flaw patched in Apache Kafka](https://portswigger.net/daily-swig/remote-code-execution-flaw-patched-in-apache-kafka) by Charlie Osborne, February 2023.
- [Medium](https://medium.com/search?q=Elasticsearch)
  - [Advance Optimization Techniques for Elasticsearch][blog_chye] by Lee Chye, September 2022.
  - [Apache Kafka Best Practices][blog_chintalapani] by Sriharsha Chintalapani, May 2018.
- [Best practices for right-sizing your Apache Kafka clusters to optimize performance and cost][blog_hausmann] by Steffen Hausmann, March 2022.
- [What's New in Apache Kafka 3.0.0][blog_kafka3] by Konstantine Karantasis, September 2021.
- [Connect Node.js applications to Red Hat OpenShift Streams for Apache Kafka with Service Binding][blog_shortiss] by Evan Shortiss, July 2021.
- [What is Kafka? How to Build and Dockerize a Kafka Cluster][blog_musyoka] by Faith Musyoka, July 2021.
- [Strimzi](https://strimzi.io/blog/) blog posts :
  - [Optimizing Kafka broker configuration][blog_mellor] by Paul Mellor, June 2021.
- [Compression of messages in Kafka][blog_pardi] by Fabio Pardi, June 2021.
- [Part 1: Apache Kafka for beginners - What is Apache Kafka?][blog_johansson] by Lovisa Johansson, March 2020.
- [7 mistakes when using Apache Kafka][blog_matloka] by Michal Matloka, January 2020.
- [A Practical Introduction to Kafka Storage Internals][blog_perla] by Durga Swaroop Perla, August 2018.
- [Large data packets and Kafka][blog_bockhorn] by Anchou Bockhorn.
- [Apache Kafka - How to Load Test with JMeter][blog_aladev] by Roman Aladev, December 2017.

## <span id="books">Books</span> [**&#x25B4;**](#top)

- [Event Streaming with Kafka Streams and ksqlDB][book_bejeck2] by William P. Bejeck, *early* 2022.<br/><span style="font-size:80%;">(Manning, ISBN 978-1-6172-9868-4, 325 pages)</span>
- [Kafka in Action][book_scott] by Dylan Scott et al., February 2022.<br/><span style="font-size:80%;">(Manning, ISBN 978-1-6172-9523-2, 272 pages)</span>
- [Kafka - The Definitive Guide][book_palino] by Todd Palino et al., 2021.<br/><span style="font-size:80%;">(O'Reilly, IsBN 978-1-4920-4307-2, pages)</span>
- [Effective Kafka][book_koutanov] by Emil Koutanov, March 2021.<br/><span style="font-size:80%;">(Leanpub, ISBN 979-8-6285-5851-5, 348 pages)</span>
- [Mastering Kafka Streams and ksqlDB][book_seymour] by Mitch Seymour, February 2021.<br/><span style="font-size:80%;">(O'Reilly, ISBN 978-1-4920-6249-3, 432 pages)</span>
- [Kafka Streams - Real-time Stream Processing][book_pandey] by Prashant Kumar Pandey, March 2019.<br/><span style="font-size:80%;">(Manning, ISBN 978-9-3535-1802-8, 348 pages)</span>
- [Kafka Streams in Action][book_bejeck] by William P. Bejeck, August 2018.<br/><span style="font-size:80%;">(Manning, ISBN 978-1-6172-9447-1, 280 pages)</span>

## <span id="news">News</span> [**&#x25B4;**](#top)

- [Kafka Monthly Digests](https://developers.redhat.com/author/mickael-maison) by Mickael Maison :
  - [Kafka Monthly Digest: February 2023](https://developers.redhat.com/blog/2023/03/01/kafka-monthly-digest-february-2023).
  - [Kafka Monthly Digest: January 2023](https://developers.redhat.com/blog/2023/02/01/kafka-monthly-digest-january-2023).
  - [Kafka Monthly Digest: December 2022](https://developers.redhat.com/blog/2023/01/03/kafka-monthly-digest-december-2022).
  - [Kafka Monthly Digest: November 2022](https://developers.redhat.com/blog/2022/12/05/kafka-monthly-digest-november-2022).
  - [Kafka Monthly Digest: September 2022](https://developers.redhat.com/blog/2022/10/05/kafka-monthly-digest-september-2022).
  - [Kafka Monthly Digest: August 2022](https://developers.redhat.com/articles/2022/09/13/kafka-monthly-digest-august-2022).
  - [Kafka Monthly Digest: July 2022](https://developers.redhat.com/articles/2022/08/04/kafka-monthly-digest-july-2022).

## <span id="tools">Tools</span>

- [`kafka-junit`](https://github.com/salesforce/kafka-junit) &ndash; easily create and run tests against one or more "real" [kafka] brokers.
- [Klaw](https://www.klaw-project.io/) &ndash; an open source data governance tool for [Apache Kafka][kafka].
- [librdkakfa](https://github.com/confluentinc/librdkafka) &ndash; an Apache Kafka C/C++ library.
- [Sarama](https://github.com/Shopify/sarama) &ndash; a Go library for Apache Kafka.
- [Strimzi](https://strimzi.io/) &ndash; [Kafka] on Kubernetes in a few minutes.

## <span id="tutorials">Tutorials</span> [**&#x25B4;**](#top)

- [Cloudera Products Docs][cloudera_docs] (online) - [Streaming](https://docs.cloudera.com/runtime/7.2.10/howto-streaming.html).
- [HowToDoInJava](https://howtodoinjava.com/) - Kafka tutorials:
  - [Spring Boot Kafka Multiple Consumers Example](https://howtodoinjava.com/kafka/multiple-consumers-example/) by Lokesh Gupta, June 2020.
  - [Spring Boot Kafka JsonSerializer Example](https://howtodoinjava.com/kafka/spring-boot-jsonserializer-example/) by Lokesh Gupta, June 2020.
  - [Spring Boot with Kafka – Hello World Example](https://howtodoinjava.com/kafka/spring-boot-with-kafka/) by Lokesh Gupta, May 2020.
  - [Apache Kafka – Getting Started on Windows 10](https://howtodoinjava.com/kafka/getting-started-windows-10/) by Lokesh Gupta, May 2020.
  - [Apache Kafka – Introduction](https://howtodoinjava.com/kafka/tutorial-introduction/) by Lokesh Gupta, May 2020.
- [Workshop: Get started with Apache Kafka][tutorial_maison] by Mickael Maison ([IBM Developer](https://developer.ibm.com/)), October 2020.
- [User authentication and authorization in Apache Kafka][tutorial_hashemian] by Vahid Hashemian and Mickael Maison ([IBM Developer](https://developer.ibm.com/)), November 2017.

***

*[mics](https://lampwww.epfl.ch/~michelou/)/May 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[article_carter]: https://www.instaclustr.com/apache-kafka-architecture/
[blog_aladev]: https://www.blazemeter.com/blog/apache-kafka-how-to-load-test-with-jmeter
[blog_bockhorn]: https://ipt.ch/en/impuls/large-data-packets-and-kafka
[blog_chintalapani]: https://medium.com/real-time-streaming/apache-kafka-best-practices-d9fac5c483c0
[blog_chye]: https://medium.com/csit-tech-blog/advance-optimization-techniques-for-elasticsearch-b728f59b70cc
[blog_hausmann]: https://aws.amazon.com/fr/blogs/big-data/best-practices-for-right-sizing-your-apache-kafka-clusters-to-optimize-performance-and-cost/
[blog_johansson]: https://www.cloudkarafka.com/blog/part1-kafka-for-beginners-what-is-apache-kafka.html
[blog_kafka3]: https://blogs.apache.org/kafka/entry/what-s-new-in-apache6
[blog_matloka]: https://blog.softwaremill.com/7-mistakes-when-using-apache-kafka-44358cd9cd6
[blog_mellor]: https://strimzi.io/blog/2021/06/08/broker-tuning/
[blog_musyoka]: https://www.section.io/engineering-education/what-is-kafka-how-to-build-and-dockerize-a-kafka-cluster/
[blog_pardi]: https://www.cloudkarafka.com/blog/compression-of-messages-in-kafka.html
[blog_perla]: https://medium.com/@durgaswaroop/a-practical-introduction-to-kafka-storage-internals-d5b544f6925f
[blog_shortiss]: https://developers.redhat.com/articles/2021/07/27/connect-nodejs-applications-red-hat-openshift-streams-apache-kafka-service
[blog_xxx]: https://www.blazemeter.com/blog/apache-kafka-how-to-load-test-with-jmeter
[book_bejeck]: https://www.manning.com/books/kafka-streams-in-action
[book_bejeck2]: https://www.manning.com/books/event-streaming-with-kafka-streams-and-ksqldb
[book_koutanov]: aa
[book_palino]: https://www.oreilly.com/library/view/kafka-the-definitive/9781492043072/
[book_pandey]: https://www.amazon.com/Kafka-Streams-Real-time-Stream-Processing-ebook/dp/B07NNBTYS3
[book_scott]: https://www.manning.com/books/kafka-in-action
[book_seymour]: https://www.oreilly.com/library/view/mastering-kafka-streams/9781492062486/
[cloudera_docs]: https://docs.cloudera.com/
[kafka]: https://kafka.apache.org/
[tutorial_hashemian]: https://developer.ibm.com/tutorials/kafka-authn-authz/
[tutorial_maison]: https://developer.ibm.com/tutorials/get-started-with-apache-kafka/
