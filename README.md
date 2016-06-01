# fedora-kickstarts #

This project is used to manage the Fedora kickstart files used in composing Fedora release images. 

The master branch is used by rawhide and each release branch is used by that release. 

All changes should be made via the PR workflow. 

This project is packaged in Fedora as the spin-kickstarts package allowing users to see 
and modify the kickstart files for their local needs. 

## To make a release ##

 * git clone ssh://git@pagure.io/fedora-kickstarts.git fedora-kickstarts
 * cd fedora-kickstarts
 * # If you need a specific branch other than master:
 * git checkout BRANCHNAME
 * # No tag has been added yet tag HEAD with
 * git tag VERSION
 * git push --tags
 * make
 * # Publish the released tar ball
 * make publish
 * # Clean up the generated files:
 * make clean

# bug reports #

Bugs should be reported to the spin-kickstarts bugzilla component:

https://bugzilla.redhat.com/enter_bug.cgi?product=Fedora&component=spin-kickstarts
