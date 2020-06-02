image_rebase
==============

Description
-----------

`image_rebase` allows you to change base image of existing Docker images without using `docker build`. 
This method not always safe, but could be very useful if there are many images which need to updated in short time. 
Read about limitations before using it for production.

Key Benefits
------------ 
* Very fast – doesn't download or upload any layers. Doesn't fork any process. Uses only JSON manipulation to create the rebased image.
* Docker Registry will not bloat due to added layers.
* Communicates directly to Docker Registry. Doesn't require Docker Engine. 
 
It supports different modes of operation.

### Automatic base image detection (recommended)

This mode is the simplest one to use, but requires adding of LABEL FROM to Dockerfiles of images that you want to be able to rebase later. Label should contain the name and tag of base image. 
It must be the first directive (after FROM):
    
    FROM myrepo/base_image:base_tag
    LABEL FROM=base_image:base_tag
    # rest of Dockerfile

This should be made only for images being rebased. Changing base images is not required.
Then to rebase your image execute: 

`image_rebase $registry_url myimage:mytag`. 

This command will:
* Lookup name of base image of `myimage:mytag` which is `base_image:base_tag`.
* Check if image `base_image:base_tag` has been changed since creation of `myimage:mytag`.
* Create new image if necessary and upload it to the registry under same tag. 

### Manually specifying base image

This mode does not require you to change Dockerfile. Instead, you need to specify exact version of then previous and new base images:

`image_rebase $registry_url myimage:mytag --from-base base_image:base_tag --to-base base_image:new_base_tag`

Note that `base_image:base_tag` must point to the same version of base image that was used during build of myimage. Otherwise the script will fail. 
You may use digest of image instead of tag: `base_image@sha256:XXXX`

It is possible to change non-direct base image. E.g. if there is a hierarchy of images A->B->C, it is possible to create new image having another version of A.

### Manually specifying number of layers

Instead of base image you can also specify number of history layers of myimage to copy. It could be the only way if manifest of base image used to create myimage have been already deleted.
You can retrieve history using `docker inspect <image>` and count numbers of commands added to myimage after base image. This is the most unsafe way and should be used carefully:

`image_rebase $registry_url myimage:mytag --layers 3 --to-base base_image:new_base_tag`

### Other flags

`-t`, `--tag`: save new image under different tag

`--force`: forces overwriting existing target image 

`-l-`, `--label`: name of the label that contains base image (default is `FROM`) 

### Limitations

* Docker Registry authentication is not supported
* RUN commands are not re-executed by design. Resulting layer is reused from old image. Be careful using commands whose result depends on the base image.

Prerequisites
-----------
* [Python 3.x](https://www.python.org/downloads/)
* [Docker Registry V2](https://docs.docker.com/registry/)   


Examples
----------------
See `samples` directory for examples.
