# canbus library

This library allows to access to canbus transmit TX and receive RX data

## include canbus

Include the canbus library on the project

* Arguments: none
* Returns: nothing

```jal
include canbus
```

This library in order to work properly need to got some constants from 
atachapters and canaerospace libraries, then we will need to include these
two libraries as well

```
include atachapters
include canaerospace
```

## setup\_can\_init()

Initialize the canbus registers of the MCU

* Arguments: none
* Returns: nothing


```jal
setup_can_init()
```


## add\_can\_rxfilter(word in RXFilter)

Add listen ID filter, this is for liestening only these identifiers on the bus, current version support up
to eight Canbus SFF ID's

* Arguments: 16-bit unsigned filter ID included from CANaerospace constant file
* Returns: nothing

```jal
add_can_rxfilter(id_indicated_airspeed)
```


## setup\_can\_end()

Ends the CANBus configuration for the MCU, it's called just after previous code

* Arguments: none
* Returns: nothing

```jal
setup_can_init()
add_can_rxfilter(id_indicated_airspeed)
setup_can_end()
```

... WIP