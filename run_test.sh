#!/bin/bash

# Assumes that the tracy_csvexport binary tracy_capture are available. They are part of the tracy project, build them from source from there.
# Note that LCM must be configured with DUSE_TRACY=ON to download and build tracy

tracy_csvexport_bin="/home/moritz/.local/bin/tracy-csvexport"
tracy_capture_bin="/home/moritz/.local/bin/tracy-capture"

SOURCE_DIR=$(cd "$(dirname "$0")" && pwd)
BUILD_DIR="$SOURCE_DIR"/../../lcm/build
BUILDTRACY_DIR="$SOURCE_DIR"/../../lcm/tracybuild

set -x
pkill -9 demo_instance

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <sizeJ> <runID> <result_dir> <sizeP>"
    exit 1
fi

sizeJ=$1
runID=$2
result_dir=$3
sizeP=$4

if [ "$sizeP" -gt 0 ]; then
    echo "---------------------------------------------------------------"
    echo "Running Setup: $sizeP lcmsec_instances;"
    echo "---------------------------------------------------------------"

    for ((i=0; i<=sizeP; i++)); do
        LD_LIBRARY_PATH="$BUILD_DIR"/lcm ./demo_instance test_instances/$((sizeJ+10+i)).toml 2>/dev/null 1>/dev/null &
    done
    sleep 12
fi

echo "---------------------------------------------------------------"
echo "Running $sizeJ lcmsec_instances; run $runID"
echo "---------------------------------------------------------------"
echo

tracy_filename="$result_dir/${sizeJ}_players_run_${runID}.tracy"
csv_filename="$result_dir/result_${sizeJ}_players_run_${runID}.csv"
capture_cmd=($tracy_capture_bin -o $tracy_filename -s 10 -f)
"${capture_cmd[@]}" &
p_capture=$!

sleep 1

LD_LIBRARY_PATH="$BUILDTRACY_DIR"/lcm ./demo_instance test_instances/1.toml &
for ((i=2; i<=sizeJ; i++)); do
    LD_LIBRARY_PATH="$BUILD_DIR"/lcm ./demo_instance test_instances/${i}.toml 2>/dev/null 1>/dev/null &
done

echo "wait on capture finish"
wait $p_capture

sleep 1

pkill -TERM demo_instance

convert_command=($tracy_csvexport_bin $tracy_filename)

"${convert_command[@]}" > $csv_filename
