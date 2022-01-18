current_branch := $(shell git rev-parse --abbrev-ref HEAD)

.PHONY: build
build:
	docker build -t hbase-base:latest ./base
	docker build -t hbase-master:latest ./hmaster
	docker build -t hbase-regionserver:latest ./hregionserver

.PHONY: tag
tag:
	docker tag hbase-base:latest firefoxx04/hbase-base:latest
	docker tag hbase-master:latest firefoxx04/hbase-master:latest
	docker tag hbase-regionserver:latest firefoxx04/hbase-regionserver:latest
	docker tag hbase-base:latest firefoxx04/hbase-base:$(current_branch)
	docker tag hbase-master:latest firefoxx04/hbase-master:$(current_branch)
	docker tag hbase-regionserver:latest firefoxx04/hbase-regionserver:$(current_branch)

# run one time to re-tag hadoop images
.PHONY: push-hadoop
push-hadoop:
	docker pull bde2020/hadoop-namenode:2.0.0-hadoop2.7.4-java8
	docker tag bde2020/hadoop-namenode:2.0.0-hadoop2.7.4-java8 firefoxx04/hadoop-namenode:latest
	docker push firefoxx04/hadoop-namenode:latest
	
	docker pull bde2020/hadoop-datanode:2.0.0-hadoop2.7.4-java8
	docker tag bde2020/hadoop-datanode:2.0.0-hadoop2.7.4-java8 firefoxx04/hadoop-datanode:latest
	docker push firefoxx04/hadoop-datanode:latest

	docker pull bde2020/hadoop-resourcemanager:2.0.0-hadoop2.7.4-java8
	docker tag bde2020/hadoop-resourcemanager:2.0.0-hadoop2.7.4-java8 firefoxx04/hadoop-resourcemanager:latest
	docker push firefoxx04/hadoop-resourcemanager:latest

	docker pull bde2020/hadoop-nodemanager:2.0.0-hadoop2.7.4-java8
	docker tag bde2020/hadoop-nodemanager:2.0.0-hadoop2.7.4-java8 firefoxx04/hadoop-nodemanager:latest
	docker push firefoxx04/hadoop-nodemanager:latest

	docker pull bde2020/hadoop-historyserver:2.0.0-hadoop2.7.4-java8
	docker tag bde2020/hadoop-historyserver:2.0.0-hadoop2.7.4-java8 firefoxx04/hadoop-historyserver:latest
	docker push firefoxx04/hadoop-historyserver:latest

.PHONY: build
push: build tag
	docker push firefoxx04/hbase-base:latest
	docker push firefoxx04/hbase-master:latest
	docker push firefoxx04/hbase-regionserver:latest
	docker push firefoxx04/hbase-base:$(current_branch)
	docker push firefoxx04/hbase-master:$(current_branch)
	docker push firefoxx04/hbase-regionserver:$(current_branch)
