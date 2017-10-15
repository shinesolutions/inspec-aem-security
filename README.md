[![Build Status](https://img.shields.io/travis/shinesolutions/inspec-aem-security.svg)](http://travis-ci.org/shinesolutions/inspec-aem-security)

InSpec AEM Security
-------------------

An [InSpec](https://www.inspec.io) profile for compliance with [AEM security checklist](https://helpx.adobe.com/experience-manager/6-2/sites/administering/using/security-checklist.html).

Usage
-----

Run all checks with master branch version:

    inspec exec https://github.com/shinesolutions/inspec-aem-security

TODO: instruction to overwrite remote hosts

Development
-----------

Clone InSpec AEM Security:

    git clone https://github.com/shinesolutions/inspec-aem-security

Run all checks against local AEM author, publish, and publish-dispatcher:

    make check

Run specific checks per component:

    make check-author
    make check-publish
    make check-publish-dispatcher
