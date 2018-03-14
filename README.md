[![Build Status](https://img.shields.io/travis/shinesolutions/inspec-aem-security.svg)](http://travis-ci.org/shinesolutions/inspec-aem-security)

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
