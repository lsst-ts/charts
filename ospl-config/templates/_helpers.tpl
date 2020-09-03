{{/*
Create chart name and version as used by the chart label.
*/}}

{{- define "ospl-config.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ospl-config.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ospl-config.xml" -}}
<OpenSplice>
    <Domain>
        <Name>ospl_sp_ddsi</Name>
        <Id>{{- .Values.domainId | default 0 -}}</Id>
        <Description>Federated deployment using shared-memory and standard DDSI networking.</Description>
        <Database>
           <Size>{{- .Values.shmemSize | default 104857600 -}}</Size>
        </Database>
        <Service name="ddsi2">
            <Command>ddsi2</Command>
        </Service>
        <Service name="durability">
            <Command>durability</Command>
        </Service>
        <Service enabled="false" name="cmsoap">
            <Command>cmsoap</Command>
        </Service>
        <ResourceLimits>
           <MaxSamples>
             <WarnAt>{{- .Values.maxSamplesWarnAt | default 50000 -}}</WarnAt>
           </MaxSamples>
        </ResourceLimits>
        <Daemon>
          <shmMonitor>
             <Scheduling>
               <Class>{{- .Values.schedulingClass | default "Default" -}}</Class>
               <Priority>{{- .Values.schedulingPriority | default 0 -}}</Priority>
             </Scheduling>
             <StackSize>{{- .Values.monitorStackSize | default 6000000 -}}</StackSize>
          </shmMonitor>
        </Daemon>
    </Domain>
    <DDSI2Service name="ddsi2">
        <General>
            <NetworkInterfaceAddress>{{- .Values.networkInterface | default "AUTO" -}}</NetworkInterfaceAddress>
            <AllowMulticast>true</AllowMulticast>
            <EnableMulticastLoopback>true</EnableMulticastLoopback>
            <CoexistWithNativeNetworking>false</CoexistWithNativeNetworking>
        </General>
        <Compatibility>
            <!-- see the release notes and/or the OpenSplice configurator on DDSI interoperability -->
            <StandardsConformance>lax</StandardsConformance>
            <!-- the following one is necessary only for TwinOaks CoreDX DDS compatibility -->
            <!-- <ExplicitlyPublishQosSetToDefault>true</ExplicitlyPublishQosSetToDefault> -->
        </Compatibility>
        <Discovery>
           <ParticipantIndex>none</ParticipantIndex>
        </Discovery>
        <Internal>
          <Watermarks>
             <WhcHigh>{{- .Values.waterMarksWhcHigh | default "8MB" -}}</WhcHigh>
          </Watermarks>
          <DeliveryQueueMaxSamples>{{- .Values.deliveryQueueMaxSamples | default 2500 -}}</DeliveryQueueMaxSamples>
        </Internal>
    </DDSI2Service>
    <DurabilityService name="durability">
        <Network>
            <Alignment>
                <TimeAlignment>false</TimeAlignment>
                <RequestCombinePeriod>
                    <Initial>2.5</Initial>
                    <Operational>0.1</Operational>
                </RequestCombinePeriod>
            </Alignment>
            <WaitForAttachment maxWaitCount="100">
                <ServiceName>ddsi2</ServiceName>
            </WaitForAttachment>
        </Network>
        <NameSpaces>
            <NameSpace name="defaultNamespace">
                <Partition>"{{- .Values.lsstDdsPartitionPrefix -}}.*"</Partition>
            </NameSpace>
            <Policy alignee="Initial"
                    aligner="true"
                    durability="Durable"
                    masterPriority="${OSPL_MASTER_PRIORITY:-1}"
                    nameSpace="defaultNamespace"/>
        </NameSpaces>
    </DurabilityService>
    <TunerService name="cmsoap">
        <Server>
            <PortNr>50000</PortNr>
        </Server>
    </TunerService>
</OpenSplice>
{{- end -}}
