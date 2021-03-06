# FlexMesh : A Police-Aware Modular Programming Architecture for P4

FlexMesh, a modular programming architecture for P4, is proposed to provide simplicity for building P4 programs, flexibility for orchestrating program features and reliability for enforcing network policies.

## Framework

The framework of FlexMesh is decomposed into four aspects: The core of FlexMesh, the runtime context for modules, the modules that implement various device features And the protocol aspect defining the supported protocol format and header parser.

#### Core
The [core](src/core) defines the overall architecture of FlexMesh, including the control nodes, the module inspector and the FlexMesh pipeline. Notice that the core doesn't provide any data plane functions.


#### Context
The runtime [context](src/context) for modules should be provided by module developers who want to expose parameters of their modules to other modules. FlexMesh adopts a logical namespace and all components defined in the modules are private to the modules. So we propose the global runtime context to act as a bridge between modules. And these modules can read and write the fields defined in the context, which provides an 'unsafe' way to transmit parameters.


#### Modules
[Modules](src/modules) are programmed by network operators who want to create new features to improve their networks. And there is a standard ingress function (a control flow in fact) for every module. Besides developing modules from scratch, we also provide some classic modules which can be reused.

#### Protocol

The [protocols](src/protocol) defines the network protocol used in FlexMesh.

## Install

#### Install BMv2

```bash
$ git clone https://github.com/FlexMesh/behavioral-model
$ cd <bmv2 folder>
$ ./install_deps.sh
$ ./autogen.sh
$ ./configure
$ make -j8
$ sudo make install
```
or in the FlexMesh folder
```bash
$ make install-bmv2
```
Then you can have bmv2 in <FlexMesh folder>/bmv2

## Tutorials

#### How to run FlexMesh

Please follow these steps to build run a FlexMesh demo.

1. Setup the virtual NICs and namespace.
```bash
$ cd <FlexMesh folder>
$ make setup-veth
```

2. Setup a FlexMesh module and compile the FlexMesh source code.
```bash
$ echo "l3_switch" >>config/modules
$ make compile
```
Then the P4 binary code "FlexMesh.json" is generated into the "build" folder.

3. Run FlexMesh on BMv2
Firstly, check whether the "SWITCH_DIR" parameter in Makefile is right or change it to the right director.(TODO: This can be automatically done.) 
```bash
make run
```

4. Populate L3_switch 
```bash
make populate-l3
```

5. Test the reachability h1 and h2
```bash
$ sudo ip netns exec h1 bash
$ ping 10.0.0.2
``` 

#### How to build a module

Please go to [SAMPLE-MODULE](src/module/sample-module.md) to find out more information.

#### How to add new protocols

Please go to [SAMPLE-PROTOCOL](src/protocol/sample-protocol.md)nd out more information.
