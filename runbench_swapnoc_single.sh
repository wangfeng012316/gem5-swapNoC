#!/bin/bash

bench_caps=( 'EDGE_50' )
bench=( 'edge_50' )

out_dir="/usr/scratch/mayank/nocs_intraswap_rslt/swapnoc/singleflit_pkt"

cycles=10000
vnet=0 #for single-flit pkt
num_cores=64
vc=1
tr=1
depth=$1 #fixed depth wormhole-queue
link_width_bits=64
################# Give attention to the injection rate that you have got#############################
for b in 0 
do
for (( i = 1; i < ${depth}; i++ )); 
do
for k in 0.02 0.04 0.06 0.08 0.10 0.12 0.14 0.16 0.18 0.20 0.22 0.24 0.26 0.28 0.30 0.32 0.34 0.36 0.38 0.40 0.42 0.44 0.46 0.48 0.50
do
    ./build/Garnet_swapnoc_tail/gem5.debug -d $out_dir/${num_cores}c/${depth}/${bench_caps[$b]}/tr-${tr}/vnet-${vnet}_vc-${vc}_depth-${depth}_inj-${k}/threshold-${i} configs/example/garnet_synth_traffic.py --topology=Mesh_XY --num-cpus=${num_cores} --num-dirs=${num_cores} --mesh-rows=8 --network=garnet2.0 --router-latency=$tr  --sim-cycles=$cycles --enable-wormhole=1 --enable-intraswap=1 --wormhole-buffer-depth=${depth} --intraswap-threshold=${i} --inj-vnet=${vnet} --injectionrate=${k} --synthetic=${bench[$b]} &
done
done
done
