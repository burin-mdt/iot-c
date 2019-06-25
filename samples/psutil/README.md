# IBM Watson IoT Platform cpsutil Device Client

Device code for sending system utilization data to IBM Watson IoT Platform.

The following data points are collected:
 * CPU utilization (%)
 * Total system memory (KB)
 * Memory used by psutil (KB)
 * Outbound network utilization across all network interfaces (KB/s)
 * Inbound network utilization across all network interfaces (KB/s)
 * Disk read rate (KB/s)
 * Disk write rate (KB/s)


## Event Format

- `name` hostname of the system
- `cpu` percent of CPU used by this process
- `mem` percent of memory used by this process
- `network.up` Outbound network utilization (KB/s)
- `network.down` Inbount network utilization (KB/s)
- `disk.write` disk write rate (KB/s)
- `disk.read` disk read rate (KB/s)

## Before you Begin

Register a device with IBM Watson IoT Platform.  

For information on how to register devices, see the [Connecting Devices](https://www.ibm.com/support/knowledgecenter/SSQP8H/iot/platform/iotplatform_task.html) topic in the IBM Watson IoT Platform documentation.  

At the end of the registration process, make a note of the following parameters: 
   - Organization ID
   - Device Type
   - Device ID
   - Authentication Token  

## Docker

The easiest way to test out the sample is via the [wiotp/psutil](https://cloud.docker.com/u/wiotp/repository/docker/wiotp/psutil) Docker image provided and the `--quickstart` command line option.

```
$ docker run -d --name cpsutil wiotp/cpsutil --quickstart
cpsutil
$ docker logs -tf cpsutil
2019-05-07T11:09:19.672513500Z 2019-05-07 11:09:19,671   wiotp.sdk.device.client.DeviceClient  INFO    Connected successfully: d:quickstart:iotcpsutil:242ac110002
```

To connect as a registered device in your organization you must set the following environment variables in the container's environment. These variables correspond to the device parameters for your registered device: 
- `WIOTP_IDENTITY_ORGID`
- `WIOTP_IDENTITY_TYPEID`
- `WIOTP_IDENTITY_DEVICEID`
- `WIOTP_AUTH_TOKEN`.

The following example shows how to set the environment variables:

```
$ export WIOTP_IDENTITY_ORGID=myorgid
$ export WIOTP_IDENTITY_TYPEID=mytypeid
$ export WIOTP_IDENTITY_DEVICEID=mydeviceid
$ export WIOTP_AUTH_TOKEN=myauthtoken
$ docker run -d -e WIOTP_IDENTITY_ORGID -e WIOTP_IDENTITY_ORGID -e WIOTP_AUTH_TOKEN --name psutil wiotp/psutil
psutil
$ docker logs -tf psutil
2019-05-07T11:09:19.672513500Z 2019-05-07 11:09:19,671   wiotp.sdk.device.client.DeviceClient  INFO    Connected successfully: d:myorgid:mytypeid:mydeviceid
```


## Installation
Installation across all OS's is pretty much the same:

- Install any necessary system packages missing from the host (in order to [install psutil on Windows](https://github.com/giampaolo/psutil/blob/master/INSTALL.rst#windows) you'll need Visual Studio installed)
- Install the `wiotp-sdk` and `psutil` python modules using `pip`
- [Download](https://github.com/ibm-watson-iot/iot-python/archive/master.zip) the sample code from GitHub
- Run the sample

The following example shows the setup process on **Raspbian** (Raspberry Pi).

```
pi@raspberrypi ~ $ sudo apt-get update
pi@raspberrypi ~ $ sudo apt-get install python-dev python-pip
pi@raspberrypi ~ $ sudo pip install wiotp-sdk psutil
pi@raspberrypi ~ $ wget https://github.com/ibm-watson-iot/iot-python/archive/master.zip
pi@raspberrypi ~ $ unzip master.zip
pi@raspberrypi ~ $ cd iot-python-master/samples/psutil/src
pi@raspberrypi ~ $ python iotpsutil.py --quickstart
(Press Ctrl+C to disconnect)

```


## Support Application
A sample application is provided that allows commands to be sent to the device when used in registered mode only.

The application provides two functions:
 * Adjust the publish rate of the psutil device sample 
 * Print a debug message to the console on the device

```
python psutilApp.py -c application.yaml
Command List:
 1. Change target device
(Ctrl+C to disconnect)
None:None>1

 0. Manually enter type and ID
 1. 001:psutil
Choose Device >1

Command List:
 1. Change target device
 2. Set publish rate of psutil:001
 3. Send message to console of psutil:001
(Ctrl+C to disconnect)
psutil:001>2

Enter Interval (seconds) >10

Command List:
 1. Change target device
 2. Set publish rate of psutil:001
 3. Send message to console of psutil:001
(Ctrl+C to disconnect)
psutil:001>
```
