# [PROPOSED] Wiki addendum: Grabbing AMD GPU Ids via rocminfo for GPU isolation / restricting ollama GPUs via ROCR_VISIBLE_DEVICES or ROCM_VISIBLE_DEVICES (ROCM) #12945
Save-copy: https://github.com/ollama/ollama/issues/12945


If you want to figure out the GPU Ids to limit GPU selection to certain GPUs (being visible) and you have an AMD GPU. 
You want to specify `ROCR_VISIBLE_DEVICES` or earlier's `ROCM_VISIBLE_DEVICES` (did that even work at some point?) to allow it being included as env vars during container build or ollama start in advance

## Prerequisites  (e.g. on Arch)
```bash
pacman -Qyuuu # (abort updating, just refreshing the repos)
pacman -S  rocm-smi-lib rocm-hip-sdk 
```

## Identification of the rocminfo and rocm-smi binaries
a ` whereis rocminfo` (and rocm-smi)

May return something like `/opt/rocm/bin/rocminfo `

## Grabbing the GPU Ids using rocminfo
```
/opt/rocm/bin/rocminfo | grep -Ei "Marketing|Uuid"
```

That should output something like:
```
Uuid:                    CPU-XX
Marketing Name:          AMD XXXXXX # <-- CPU's one
Uuid:                    GPU-XXXXXXXXXXXXXX # <--- thats what we need the ded. GPU's uuid
Marketing Name:          AMD Radeon XXXXX # <-- to verify the card's common product name!
```

## Adding GPU Ids to env ``ROCR_VISIBLE_DEVICES` (or ROCM..._DEVICES) var 
Finally, add the `uuid` (here the 2nd, dedicated GPU; not the CPU's one) to your docker build file as env `ENV ROCR_VISIBLE_DEVICES=GPU-XXXXXXX` 

## Testing the results
After rebuilding the container and starting ollama (or on baremetal), the logs should show something like:
```
time=XXXXX level=INFO source=routes.go:1511 msg="server config" env="map[CUDA_VISIBLE_DEVICES[...]:[....] OLLAMA_REMOTES:[ollama.com] [...] ROCR_VISIBLE_DEVICES:GPU-XXXXXXXXXXX  [...] ]"
```
A bit later (downwards) in the logs we should see that this gpu is actually loaded ONLY. 

**If our previously grabbed GPU-Id is present, the test result shall be successful. Otherwise something is wrong.** 

**Note**: I added [...] to skip the noisy other env vars, to make it more visible to you. Once the ROCR env var is filled, and detected as server config var, it should skip the detection algorithms and just use the gpu ("faster" startup?), and usually only use that one.

**Important note**: `ROCM_VISIBLE_DEVICES` did nothing for me! However, **ROCR** does work!

## Sources
- https://rocm.docs.amd.com/en/latest/conceptual/gpu-isolation.html
- https://gitlab.informatik.uni-halle.de/ambcj/ollama/-/blob/d1692fd3e0b4a80ff55ba052b430207134df4714/docs/gpu.md

## NOTE (after posting this)
As far as I am seeing, perhaps this could be an addition to the well-writtten https://docs.ollama.com/gpu#gpu-selection and https://docs.ollama.com/gpu#gpu-selection-2

I was not able to find it via Search Engines (e.g. Google, StartPage & DuckDuck; prob. because its heavy-loaded with JS templating stuff - SEs being somehow unable to parse that; or due to its ranking). I intentionally looked for that, after posting this, via the docs own search.
