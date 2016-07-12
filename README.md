# dripl

An interactive terminal for Druid. It allows fetching metadata and constructing and sending queries to a Druid cluster.

## Installation

```
$ gem install dripl
```

## Usage

```
$ dripl --zookeeper localhost:2181
>> sources
[
    [0] "events"
]

>> use 0
Using events data source

>> metrics
[
    [0] "actions"
    [1] "words"
]

>> dimensions
[
    [0] "type"
]

>> long_sum(:actions)
+---------+
| actions |
+---------+
|   98575 |
+---------+

>> long_sum(:actions, :words).last(3.days).granularity(:day)
+---------------+---------------+
| actions       | words         |
+---------------+---------------+
| 2013-12-11T00:00:00.000+01:00 |
+---------------+---------------+
| 537345        | 68974         |
+---------------+---------------+
| 2013-12-12T00:00:00.000+01:00 |
+---------------+---------------+
| 675431        | 49253         |
+---------------+---------------+
| 2013-12-13T00:00:00.000+01:00 |
+---------------+---------------+
| 749034        | 87542         |
+---------------+---------------+

>> long_sum(:actions, :words).last(3.days).granularity(:day).as_json
{
      :dataSource => "events",
     :granularity => {
            :type => "period",
          :period => "P1D",
        :timeZone => "Europe/Berlin"
    },
       :intervals => [
        [0] "2013-12-11T00:00:00+01:00/2013-12-13T09:41:10+01:00"
    ],
       :queryType => :groupBy,
    :aggregations => [
        [0] {
                 :type => "longSum",
                 :name => :actions,
            :fieldName => :actions
        },
        [1] {
                 :type => "longSum",
                 :name => :words,
            :fieldName => :words
        }
    ]
}
```
