# Jenkins JCasC modes

In Jenkins Configuration as Code (JCasC), the terms "EXCLUSIVE" and "NORMAL" refer to different modes of operation for handling Jenkins configurations. These modes are relevant when applying configurations using JCasC and can affect how existing configurations are managed and modified.

    EXCLUSIVE Mode:
        In EXCLUSIVE mode, the configuration specified in your JCasC YAML file fully controls the configuration of Jenkins.
        Any existing configurations not specified in the JCasC YAML file will be removed.
        It's a way to enforce a strict, controlled configuration where only the elements specified in the YAML file are allowed to exist.
        This mode is useful if you want to have full control over the configuration and ensure that only the desired settings are applied.

    NORMAL Mode:
        In NORMAL mode, the configuration specified in your JCasC YAML file is applied, but existing configurations not mentioned in the YAML file are preserved.
        Existing configurations not specified in the YAML file will remain unchanged.
        This mode is more permissive and allows for a mix of manually configured settings in the Jenkins instance and settings specified in the YAML file.
        It is often used when transitioning to JCasC, allowing for a more gradual adoption of configuration as code.