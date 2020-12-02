[![Build Status](https://github.com/shinesolutions/inspec-aem-security/workflows/CI/badge.svg)](https://github.com/shinesolutions/inspec-aem-security/actions?query=workflow%3ACI)

InSpec AEM Security
-------------------

An [InSpec](https://www.inspec.io) profile for compliance with [AEM security checklist](https://helpx.adobe.com/experience-manager/6-2/sites/administering/using/security-checklist.html).

Usage
-----

Run profile directly from Chef Supermarket:

    inspec supermarket exec shinesolutions/aem-security

Run profile directly from GitHub:

    inspec exec https://github.com/shinesolutions/inspec-aem-security

Run all tests:

    make test

Run all tests with custom configuration file:

    INSPEC_AEM_SECURITY_CONF=some-aem.yaml make test

Run component specific tests:

    make test-author
    make test-publish
    make test-publish-dispatcher
