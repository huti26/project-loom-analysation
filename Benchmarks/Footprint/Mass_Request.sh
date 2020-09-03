
# bash Mass_Request.sh 50 1000 t/vt 100
CONCURRENT_CONNECTIONS=$1
TOTAL_REQUESTS=$2
THREAD_TYPE=$3
RUNS=$4

SERVER_ADDRESS=http://localhost:5566/ 


FOLDER_NAME="$CONCURRENT_CONNECTIONS-$TOTAL_REQUESTS-$THREAD_TYPE"
mkdir $FOLDER_NAME


AB="ab -c $CONCURRENT_CONNECTIONS -n $TOTAL_REQUESTS -k $SERVER_ADDRESS"

# runs the command $RUNS times
# saves all runs in individual files
for ((i=1;i<=$RUNS;i++));
do
echo
echo Run $i:
$AB > ./$FOLDER_NAME/run$i.txt
done