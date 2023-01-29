[33mcommit 089c512f53c498971ad19f8822ef9f33737f7422[m[33m ([m[1;36mHEAD -> [m[1;32mmain[m[33m, [m[1;31morigin/main[m[33m)[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Jan 27 23:23:07 2023 -0500

    comment window can now be cancelled by clicking outside of window

[33mcommit cfd62599010696a900ab8f7314c58ddf7f5229ca[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Jan 27 10:48:54 2023 -0500

    username displayed correctly in nav tab

[33mcommit 9ac4d51612401072adf91cc1c273b1b883312092[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Jan 26 19:30:29 2023 -0500

    clean up code, add focus form when user clicks on reply/edit

[33mcommit 0794a710ea1e3982376f2e4a987c64de34897192[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Jan 25 16:10:27 2023 -0500

    refactored code for turbo streams and pagination

[33mcommit d1e0abb4fc12853484bdfb42f071717707e329b9[m
Author: kenta <ktohara@gmail.com>
Date:   Tue Jan 24 22:03:57 2023 -0500

    turbo broadcasts with view more comments/show more replies works a little better

[33mcommit c2da4ae5ca728dbd22cfc343edceec24947c0deb[m
Author: kenta <ktohara@gmail.com>
Date:   Tue Jan 24 14:44:43 2023 -0500

    fix turbo broadcasts and pagy comment loading for deletion

[33mcommit 9bc56cbec293b13a4ace7cfb70c7efb9992a85e8[m
Author: kenta <ktohara@gmail.com>
Date:   Tue Jan 24 00:28:40 2023 -0500

    notification links now route to its own post/comments page

[33mcommit 3919e77f7e543de165b62b93f78cf865609fa059[m
Author: kenta <ktohara@gmail.com>
Date:   Sun Jan 22 16:46:25 2023 -0500

    updated comment/post forms to show user avatar

[33mcommit ef2f88605be1325a08d0976878071e70a6f8ade1[m
Author: kenta <ktohara@gmail.com>
Date:   Sun Jan 22 14:49:43 2023 -0500

    fix nested comments and load more comments to be more akin to facebook styling

[33mcommit 7ea2b4d92e16e1b675fb873ce291c229a75ce200[m
Author: kenta <ktohara@gmail.com>
Date:   Sat Jan 21 23:57:19 2023 -0500

    fix nested comments, wip fix notifications

[33mcommit 75d65ef8b71ab5e4df3b8328a7c8948891e78be7[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Jan 20 20:42:29 2023 -0500

    finish profiles

[33mcommit 0a12afd8df984851760ec491f7cfb71fb0108519[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Jan 20 14:00:05 2023 -0500

    add profile, fix styling issues

[33mcommit a34e9cf695d7c08672cc803dda31ef2362efc9eb[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Jan 20 11:11:07 2023 -0500

    add more styling to nav and links/buttons

[33mcommit f78b0168db17a961909bc121a358e253c960f790[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Jan 20 00:50:27 2023 -0500

    fix bug: turbo stream now loads with correct src (config/development.rb), add more basic styling

[33mcommit 40047797e3b9aeae9030dc3896a70e749d4d7534[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Jan 19 17:46:46 2023 -0500

    attached images for comments (bug: turbo stream src url for image points to example.org)

[33mcommit 2ecdac591c287bfb74d0ffc304fdb4da48c9fd2c[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Jan 18 19:33:20 2023 -0500

    aws s3 for file storage on production

[33mcommit 0a96ad3c727bb81b8f9c192362d996d395c57e81[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Jan 18 17:38:03 2023 -0500

    updated time_ago_in_words through en.yml for post/comments created_at

[33mcommit b7b16e95a5b3dfc94949fafd4ff484224d3c1d01[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Jan 18 14:40:55 2023 -0500

    fix turbo stream infinite scrolling (styling was causing issues for turbo frame to load)

[33mcommit f7ca67438d2aa7f4f38816453b327c1bad1d4641[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Jan 18 00:08:31 2023 -0500

    fix n+1 queries

[33mcommit 8ca10562402cf846d631b69106e95443eff606f3[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Jan 18 00:05:39 2023 -0500

    fix infinite scrolling for users/show

[33mcommit 15933bb5c8c1e1a46a2984925622efa5afd6da97[m
Author: kenta <ktohara@gmail.com>
Date:   Tue Jan 17 23:24:24 2023 -0500

    turbo frame edit cancel comments button

[33mcommit f5bc8b185a286543920fe1a0054433cee7b307ad[m
Author: kenta <ktohara@gmail.com>
Date:   Tue Jan 17 22:57:45 2023 -0500

    fix infinite scrolling nesting divs, turbo-frame post edit cancel button

[33mcommit b86edb283a0485c2dd7b2c1ee4246e088ba5b4ee[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Jan 16 20:38:32 2023 -0500

    image uploading for posts

[33mcommit 9155247e0a45e94edf33eae6b46c651d76193fe8[m
Author: kenta <ktohara@gmail.com>
Date:   Sat Jan 14 01:41:07 2023 -0500

    comments and posts have a 'show more' functionality

[33mcommit 3abd6af0ea2aed12ae9827d5fba89e52cfd3605b[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Jan 13 21:03:03 2023 -0500

    Add load more post/comments functionality

[33mcommit c5c73951612a574f87757c78710606f62d583b2d[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Jan 13 14:41:26 2023 -0500

    cleaned up unused code

[33mcommit 60c3947444a4d2d32a0ba3f9b10ba8c5b7a69773[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Jan 12 18:33:03 2023 -0500

    comments can now be clicked outside of element to close window

[33mcommit f5495c835a8060cf17ed3fdf55ed4f496061826f[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Jan 12 14:33:14 2023 -0500

    fix turbo for friendship requests

[33mcommit 5bd708cf15615ccae27711612d305d46b34eaec2[m
Author: kenta <ktohara@gmail.com>
Date:   Tue Jan 10 19:25:16 2023 -0500

    add infinite scrolling for users/show

[33mcommit 4b470cb1cdaa164094c7ed4582b469b79cdb905b[m
Author: kenta <ktohara@gmail.com>
Date:   Tue Jan 10 18:22:44 2023 -0500

    add infinite scroll for posts/index

[33mcommit 1dc74012ffba5261e8588589a0f36b32e0eceda6[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Jan 9 22:08:01 2023 -0500

    add gem: pagy - load more posts feature with turbo stream on users/show page

[33mcommit b2154bec04fce0e4508dd51af7cc9354cb83560d[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Jan 9 14:47:05 2023 -0500

    add pagy gem

[33mcommit ca8e61d7119e07bf80aae9447041f940dea04aed[m
Author: kenta <ktohara@gmail.com>
Date:   Sun Jan 8 21:23:31 2023 -0500

    update n+1

[33mcommit d5e094e0539c684461943344c2a179ec057e3fe1[m
Author: kenta <ktohara@gmail.com>
Date:   Sun Jan 8 21:16:49 2023 -0500

    implement stimulus controller (object_author) to access current_user and turbo stream broadcasts for conditional edit/delete buttons

[33mcommit dd5c6282e77ca53df1b9b02ec56333bb2267a736[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Jan 6 19:07:36 2023 -0500

    real time search for users with turbo frames

[33mcommit 0a5b24a9371b596b459192a0b1428012608f3f39[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Jan 5 19:47:43 2023 -0500

    fixed friendship request possible recursion loop

[33mcommit 5e3999bc08b6b8b8a67e06967c01fd7a494b7dbe[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Jan 5 11:11:20 2023 -0500

    users can recieve notifications for likes

[33mcommit fa9fa63e0ee6c2df4b5148dc6912c2810fa757e3[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Jan 4 23:07:34 2023 -0500

    clean up: commentables, notifications working for friendships and comments

[33mcommit 635fb39a3ac55b11d372ed6f4ba8c6a502bcef71[m
Author: kenta <ktohara@gmail.com>
Date:   Tue Jan 3 17:06:32 2023 -0500

    update n+1 queries

[33mcommit 50e4693c012b9d59c36b877e881ba52846b5cd08[m
Author: kenta <ktohara@gmail.com>
Date:   Tue Jan 3 15:27:00 2023 -0500

    update notification turbo frames for unread/read

[33mcommit 527546602364b5d2ec6cf16e0a5c7b2c1248c2fd[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Jan 2 16:54:38 2023 -0500

    wip: notifications

[33mcommit d3ba1535638e6da943c3771f5c84c266b1a9935b[m
Author: kenta <ktohara@gmail.com>
Date:   Sat Dec 31 13:38:08 2022 -0500

    fixed edit post - turbo frame was not connected to posts/edit view

[33mcommit ce90d65373eb7abf4530f3d82e3c51a3dd858a56[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Dec 30 20:25:03 2022 -0500

    users can now add/remove likes from posts and comments

[33mcommit 4b878f8243fc4ac15e175ce9c2a67ad8a2fe3c6b[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 29 21:28:51 2022 -0500

    add like migration, model, validations, spec

[33mcommit 865b553564a92061d165408401dac6e1e6abec57[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 29 19:22:35 2022 -0500

    users can now post on other users' pages

[33mcommit e15ab876b370307001ca4b1aa86e8d975e15c2af[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 29 13:38:48 2022 -0500

    fix feed, n+1 queries

[33mcommit e39ec7415617b1f67b0d5a437a597d6675e4f407[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 29 12:18:24 2022 -0500

    turbo nested comments working

[33mcommit 133ae87cc2a328fafb3a41e6eb3cde68130fc313[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Dec 26 17:11:25 2022 -0500

    fix bug: post could not be submitted when opening edit window

[33mcommit 469dc6e2662bd21af74e8e3a33913ba4885019da[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Dec 26 17:07:14 2022 -0500

    add functionality: edit post, form cannot be submitted unless filled out

[33mcommit aa857a92f7549a0fd449fa9a2ea0d466a5acbf9f[m
Author: kenta <ktohara@gmail.com>
Date:   Sun Dec 25 16:15:10 2022 -0500

    add edit comment functionality

[33mcommit 3442d6579094c85d75bc7f563aa219619efca8d9[m
Author: kenta <ktohara@gmail.com>
Date:   Sat Dec 24 18:22:03 2022 -0500

    turbo deletion of comments

[33mcommit 05568d231e2aedb8eaa0ad34e0802f936d4df2f5[m
Author: kenta <ktohara@gmail.com>
Date:   Sat Dec 24 18:02:00 2022 -0500

    update comments for turbo, deletion of comments still WIP

[33mcommit f48106d7cfa1d28b6c9bea4da2e4743d3cd4dd05[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Dec 23 21:44:00 2022 -0500

    fixed bug where user could not delete nested comment

[33mcommit 8f6ff7d0b986e33e2d34d8697fbac5b03dc01631[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Dec 23 13:59:34 2022 -0500

    more n+1 query updates on models: post, comment

[33mcommit 1cc73cac3f666c48063b35e769f348b530a1578f[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Dec 23 11:13:17 2022 -0500

    update n+1 query on models: post, comment

[33mcommit 5aeee3594fd645eb089e8865c36f759d44362c16[m
Author: kenta <ktohara@gmail.com>
Date:   Fri Dec 23 11:03:43 2022 -0500

    update comment instance method into actual association

[33mcommit 27cc641ee1127760977733eb21c79c0ed9ecafd8[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 22 20:12:07 2022 -0500

    edit: linter

[33mcommit 28b492cf3100b1fb9d273c43b22409174f0f2aaf[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 22 19:57:51 2022 -0500

    add comment counter to posts

[33mcommit 6e1ea721d268d70c557ac207b4e5bcf8f1564e05[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 22 18:40:00 2022 -0500

    refactor nested comments to be more dynamic

[33mcommit 24251ed0d7ee24d4c569f5875430d222aa574786[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 22 00:09:07 2022 -0500

    users can now add nested comments

[33mcommit 3d82665ffddd83938c3f7406a98e4d98e7b7d5e5[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Dec 21 19:08:54 2022 -0500

    users can now make comments

[33mcommit 572418428447ba7c77953ed7e263f46931639bcc[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Dec 19 16:18:46 2022 -0500

    add comment model specs

[33mcommit bea4163ed16495411ca210d2faa7766ca5e8baea[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Dec 19 15:55:26 2022 -0500

    add comment associations and validations

[33mcommit f857d1543ff0bf2bc55ee5752b95293265707056[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Dec 19 15:50:21 2022 -0500

    clean up views, create comment model

[33mcommit 72fc874b0987aa130690e5e5db7de84caf5603e7[m
Author: kenta <ktohara@gmail.com>
Date:   Mon Dec 19 00:08:44 2022 -0500

    update specs

[33mcommit 1eafc45dbca0157fc7b58723c1bfb30a00e1e57e[m
Author: kenta <ktohara@gmail.com>
Date:   Sun Dec 18 23:10:49 2022 -0500

    include gem: bullet

[33mcommit d32ae86d34535ab7683b9ccbc898f68d07b6bde6[m
Author: kenta <ktohara@gmail.com>
Date:   Sun Dec 18 23:04:08 2022 -0500

    users can now add/remove/update friendships

[33mcommit a27130692177bbac8efea36933e058d310ffac1e[m
Author: kenta <ktohara@gmail.com>
Date:   Sun Dec 18 16:38:06 2022 -0500

    add basic search functionality

[33mcommit 3e557fc60a8f2eb51cf2ff87a9f3b202c06e25e0[m
Author: kenta <ktohara@gmail.com>
Date:   Sat Dec 17 23:42:58 2022 -0500

    update model specs

[33mcommit 78253d05fb4daae8631a91a9afb31147f87bdf9a[m
Author: kenta <ktohara@gmail.com>
Date:   Sat Dec 17 17:40:25 2022 -0500

    added basic friendship model

[33mcommit 6e0636fc9f50bcf02fe3324e8e9477dffd05108f[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 15 14:00:27 2022 -0500

    add friendship model

[33mcommit a83e07cdb64b1cc1708caa063fd9bdf5a279d407[m
Author: kenta <ktohara@gmail.com>
Date:   Thu Dec 15 11:16:17 2022 -0500

    add route specs

[33mcommit dc4fb1910d5c168c3e266bc16c308df446c15eb8[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Dec 14 20:53:17 2022 -0500

    create basic posts mvc

[33mcommit 450d6807dda5dc44717cf6b181a3404ba5d2bd2b[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Dec 14 17:59:56 2022 -0500

    add basic nav, redirect user after signout to signup

[33mcommit 4008b3ab6528a0858c30ba56a24e5bbc20ab39f8[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Dec 14 17:35:11 2022 -0500

    add post model and basic association/validations

[33mcommit b0e8bb3678b2f6a4f19fb4cd6ccaea198f899b87[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Dec 14 16:46:54 2022 -0500

    add basic user validation

[33mcommit 348277c8a7c5d7e48068bf5b367f90e86d559139[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Dec 14 14:29:43 2022 -0500

    setup figaro

[33mcommit 7cf07cd3404bcb6f3157779e47705c0ac2e51638[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Dec 14 14:26:52 2022 -0500

    setup rspec

[33mcommit 1fcf9b8173e6d9dd3a99d9d69edcd2942cb6ca43[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Dec 14 14:09:19 2022 -0500

    setup devise, add turbo false to all devise forms

[33mcommit cbb4a1151503bc84ca221c14c321f05b0ce4a025[m
Author: kenta <ktohara@gmail.com>
Date:   Wed Dec 14 13:48:16 2022 -0500

    first commit
