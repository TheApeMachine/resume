# Active Projects

## Markdown Repository to Resume

[Project Link](https://gitlab.itoodev.com/resume)

Basically it is the document you are reading.
An instance of Gitlab running on my local cluster at home contains many Markdown files that each are a different section of my resume.
A Dockerfile is also included with is configured to act as a "compiler" for the Markdown files, first concatenating them into a single
in-memory file on-the-fly, and then writing it to PDF for a final output that can be shared with recruiters and potential employers.

I did this because I kept rewriting my resume every single time, as I never had the original files anywhere I would not lose them
eventually.
This way I can just push updates to the Git repository, and the CI/CD pipeline will build me a newly updated resume, and all I have to
share is the link to the PDF download.

## Wrkspc

[Project Link](https://gitlab.itoodev.com/wrkgrp/wrkspc)

A dynamic workspace that aims to make developer life easier.
This project stems from a recent situation where we had to work on a .Net 4.7.1 + Php 5.6.40 stack that was very difficult to set up
and get running locally, and would also not have all the elements to reflect production.
To circumvent lack of Docker knowledge in the company, and lack of time to train, this Go project has everything needed to run Docker
containers built into the binary itself, using the open source code from the [Moby](https://github.com/moby/moby) project.
This means Docker itself does not need to be installed on the local machine.

In essence it works like a standard command-line interface, however it does not contain any logic to perform the commands it supports.
All of that logic is abstracted away into Dockerfiles, which are dynamically downloaded, built, and run from any public or private Docker registry.

In such it acts as a wrapper around any tool you would normally install via a package manager of some sorts, while also being able to simplify
the more complex operations such tools can offer.
The purpose being to reduce learning curves for people unfamiliar with specific tools and still providing the benefits they can have.

Besides existing tools, new ones can (and have) also been created, and some practical examples that relate to the project mentioned earlier are:

    - A tool that can automatically provision QEMU KVM based virtual machines with tiny Alpine LXC containers running a Docker node in a Swarm on any machine on the local network it has access to.
    - A container that updates from a Git repository and serves the files over a remote share (SMB or NFS).
    - A fully configured code editing setup based on Vim and curated plugins.

The plug-and-play and modular nature of this tool makes it so that it is easily adapted to other projects, and is my main way of working on anything at the moment.
The benefit of using this in a company is that it has the potential (if used to its full extend) to unload most of the processing that would need to be done on a local development machine
to a Docker Swarm (which a previously mentioned toolset can automatically provision), meaning that all machines in a group can become just nodes on that Swarm, and deliver a little bit of
processing resources to the group.
This is especially useful if you need to run 14.000+ integration tests (as we had to do on this project).

## SPDG

[Interface](https://gitlab.itoodev.com/wrkgrp/wrkspc) Secure Private Data Grams<br>
[Implementation]() example using MySQL binlog as an event source.

This is an effort to solve a problem that I first encountered in software aimed at providing help towards the refugee crisis while working at [QuickBed](#quickbed--cto), and which
has now resurfaced in the environmental reporting platforms.
The idea is to create a standard DataType (or really at its core it is just an interface) that is geared towards immutability, retention of historical events, privacy and trustability.
In its core the interface describes a type with a read and write operation, which only accept a Bytes Buffer in and a Bytes Buffer out.
To consume these types each individual method it passes through needs to have it's own public/private key setup to be able to read or write data to the Type, as it is decrypted and encrypted
before and after every single operation.
For this a specialized keyserver is being developed to be able to deal with a massive pool of keys, without having to worry about it.
The gist is that the owner of the data aloows or disallows access to a group of operations performed by a system, giving maximum granularity towards privacy and security.
Data is only ever written as another layer on top of what exists already in the instance of a Type, so provided access has been granted a full history of each unit of data exists within
the unit of data itself, showing how, why, and by whom it was created, stored, or mutated.
Data can theoretically not be lost, however the public key each unit exists just as another layer as well, so if that layer is somehow corrupted (a unit can also corrupt itself on purpose) it
will no longer be accessible in any way.
This has been done to give the data unit an intrinsic value, which was needed to make the trustability work.
Trustability is provided by a scoring algorithm still under development that gives each layer, and all combined, a final output score that indicates how trustworthy this particular unit of data is.

Given that this data type is built around Bytes Buffers, pretty much anything can be stored in these, and in real-world implementations so far it is the only type any method accepts or puts out.
This has provided some unforeseen benefits as well when it comes to architecture of software.
For instance in one case I transported an encrypted memory pointer through a return stack and used the MySQL client connection it was pointing at from the original calling method. This particular
example would not work over a network of course, but anything that does with traditional methods also does using this type.