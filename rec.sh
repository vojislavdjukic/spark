#!/bin/sh

#./sbin/stop-all.sh
#./sbin/stop-history-server.sh

# rsync -a  ./core/ vdukic@bach26:/mnt/local/spark/core/
# rsync -a  ./core/ vdukic@bach27:/mnt/local/spark/core/
# rsync -a  ./core/ vdukic@bach28:/mnt/local/spark/core/
# rsync -a  ./core/ vdukic@bach29:/mnt/local/spark/core/

ssh -t vdukic@bach26 '
cd /mnt/local/spark
./sbin/stop-all.sh
./sbin/stop-history-server.sh
'

#./build/mvn -Pyarn -Phadoop-2.7 -Dhadoop.version=2.7.0 -DskipTests package

ssh -t vdukic@bach21 'rm -rf /mnt/local/spark'
ssh -t vdukic@bach22 'rm -rf /mnt/local/spark'
ssh -t vdukic@bach23 'rm -rf /mnt/local/spark'
ssh -t vdukic@bach26 'rm -rf /mnt/local/spark'
ssh -t vdukic@bach27 'rm -rf /mnt/local/spark'
ssh -t vdukic@bach28 'rm -rf /mnt/local/spark'

#scp -r /home/voja/Development/spark vdukic@bach21:/mnt/local/
#scp -r /home/voja/Development/spark vdukic@bach23:/mnt/local/
#scp -r /home/voja/Development/spark vdukic@bach26:/mnt/local/
#scp -r /home/voja/Development/spark vdukic@bach22:/mnt/local/
#scp -r /home/voja/Development/spark vdukic@bach27:/mnt/local/
#scp -r /home/voja/Development/spark vdukic@bach28:/mnt/local/

rsync -a --exclude '.git' ./ vdukic@bach21:/mnt/local/spark/ &
rsync -a --exclude '.git' ./ vdukic@bach22:/mnt/local/spark/ &
rsync -a --exclude '.git' ./ vdukic@bach23:/mnt/local/spark/ &
rsync -a --exclude '.git' ./ vdukic@bach26:/mnt/local/spark/ &
rsync -a --exclude '.git' ./ vdukic@bach27:/mnt/local/spark/ &
rsync -a --exclude '.git' ./ vdukic@bach28:/mnt/local/spark/ &
wait

ssh -t vdukic@bach26 '
cd /mnt/local/spark
./sbin/start-all.sh
./sbin/start-history-server.sh
'

#./sbin/start-all.sh
#./sbin/start-history-server.sh

#MASTER=spark://bach26:7077 ./bin/run-example SparkPi 10 --executor-memory 8G  --total-executor-cores 4
