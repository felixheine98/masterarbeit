# Locked Decisions & Methodology

## Locked decisions
- ML/anomaly detection (Isolation Forest) fully removed — deliberate trade-off for focus
- RQ3 (payload formats) and RQ4 (overhead/efficiency) fill the freed capacity
- Six-device hardware lineup finalized
- Thread and Matter scoped out (different network layer) — mentioned in Related Work as a boundary
- Physical wall/distance testing ruled out in favor of reproducible netem simulation
- ESP32 not viable as Raspberry Pi substitute (no OS-level monitoring, no Mosquitto)

## Fair comparison
- All variables constant except the protocol: identical JSON payload, same send interval, same hardware and network
- MQTT QoS level documented; HTTP polling interval matched; NTP-synchronized timestamps
- Randomized test order, repeated runs, mean ± standard deviation reported

## Experimental design: two scenarios
1. **Controlled:** a recorded real Shelly trace (frozen and hashed) replayed by a Shelly emulator on a separate machine
2. **Live validation:** real devices
- Under consideration: a separate travel router as an isolated test network

## Ways of working
- Iterative work on the structure; one working document as single source of truth (`docs/thesis-struktur.md`)
- Concise briefings for supervisor meetings
- Safe, completable scope preferred; flag scope drift early
