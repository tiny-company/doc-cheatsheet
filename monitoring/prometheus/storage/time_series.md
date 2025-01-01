# time series

The time series is a stream (group) of timestamp value pair (which are definition of samples), see relative documentation about samples. A time serie represent all samples without time limitation (by default).

## representation

See below series representation over time with serie's notation on the right :

```
  ^
  │   . . . . . . . . . . . . . . . . .   . .   node_cpu{cpu="cpu0",mode="idle"}
  │     . . . . . . . . . . . . . . . . . . .   node_cpu{cpu="cpu0",mode="system"}
  │     . . . . . . . . . .   . . . . . . . .   node_load1{}
  │     . . . . . . . . . . . . . . . .   . .
  v
    <------------------ time ---------------->

```

## notation

Given a metric name and a set of labels, time series are frequently identified using this notation:
```
<metric name>{<label name>=<label value>, ...}
```

See image below :
![time series graphical representation](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fiximiuz.com%2Fprometheus-metrics-labels-time-series%2Ftime-series-2000-opt.png&f=1&nofb=1&ipt=a989241cfbf98b781cd8313d1a4eb37abdff7bcf31a8f77e202f6416684305bb&ipo=images)

