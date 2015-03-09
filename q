77b8050 Revert "Trying to make git ignore some files"
8a11540 Some Cucumber tests of existing codebase
8510879 Fixed regrading quiz spec tests
f60d470 Changed the reader's name pattern in the factory so they don't collide with staff
629989e Fixed nil dereferencing in case if there are no readers in the database
4a07c8b Fixed broken path helper (staffs_dashboard_path)
324315b Fixed broken path helper (staffs_dashboard_path)
81d008f Strange issue with the staff names not incrementing and not being unique, ducktape fixed
4842118 Changed non-existent route staffs_dashboard_path to staffs_dashboard_index_path
250c011 Fixed quiz_spec failing test
8d8022c Ignoring some files
1a9097a Ignoring some files needed to make rails run on my machine
ff9c0e4 Still does not do what I want
a88ef83 Trying to make git ignore some files
6ae2e7e Gemfile reverted
3b9253c Merge branch 'master' of https://github.com/Mduchamp/cs61as-quiz-system
c38c8a1 Trying to revert Gemfile back
1fa107e Fixed a typo in quizzes_controller, was q1 instead of ql and broke quiz submission. Trying to not mess up Gemfile and .gitignore, sorry if I do.
687e615 Fixed a typo in quizzes_controller, was q1 instead of ql, that broke the quiz submission
c0df7d7 Merge pull request #118 from SamLau95/features
95359d0 added variable quiz times
207937d added quiz_time field to system
61f0b77 Merge pull request #117 from SamLau95/features
29ea412 bugs
091a1a9 added lesson names
c4d6e3a autoindent
e78dfde removed stupid sisyphus, change to coooooookies
7da4a75 Merge branch 'master' of https://github.com/SamLau95/cs61as-quiz-system
cf88c34 quick change
bf0ac6f Merge pull request #115 from SamLau95/features
4be160b hound
0007ffd Merge branch 'features' of https://github.com/SamLau95/cs61as-quiz-system into features
03f42a1 conflicts
6d401f4 finished mailer
3c4d850 wheee suckerpunch ftw
f5ea52f added job
2a8c978 doing async stuff
f12dfe9 starting mailer
527db5b finished master
1ce14fb importing finished
dd0ec02 fixing bugs and stuff
e29a94c Merge pull request #116 from SamLau95/bugs
4810a3a can show students answers
835ae39 Fix taken_quiz factory
da5935f stuff is breaking..
258f824 trying to fix tests and stuff
6e5c17d changing things
81bcd8b added column
f601cce changed to not break
be95609 moving methods aroudn
b8cf5f0 renamed column
0fa1d03 added more sti
66b4810 added pints possible
f9b5b4f Merge pull request #113 from SamLau95/features
2ae01f8 Merge pull request #112 from SamLau95/bugs
2cf3784 parse comments as markdown
1beead8 deleted things
8ad3ef2 added page breaks and text expand
247d9db fixed search
d60710b added security back
a648759 fixed tests
a9b6054 show points now
6e0c3ba Spaces
e34cc76 fixed stats'
cbb481a tests and stuff
b4b2a4e fixed some bugs
dd5e9de minor fixes
8edf408 sigh
74156df wth
9cfb5db wooohoo
9ab25b3 replaced with rubyzip
16d354f wat
40eb935 Merge branch 'master' of heroku.com:cs61as-quizzes-staging
63ed360 Merge pull request #107 from SamLau95/bugs
2731353 deleted things
3057680 Merge branch 'master' of https://github.com/SamLau95/cs61as-quiz-system into bugs
36a465f testing
b3e2235 Merge pull request #106 from SamLau95/bugs
ccb9a4c fixed bug
b6d92dd Merge pull request #105 from SamLau95/bugs
aa72c19 fixed things
35488fb changed tests
7cf3f47 more fixes
1c7105a quick fix
8e0c378 removed back button for now
30dd197 bugs
dfbc9ce bug
3750b81 added validation
3c8fcee added solution and rubric
9972c62 Merge pull request #104 from SamLau95/bugs
7ff8e90 whoops bug
546ca28 Merge pull request #103 from SamLau95/bugs
cb34af7 Update student.rb
a6cf522 Update student.rb
081857c Update student.rb
07330c1 addedpagintion
cff568b fixedstats again
a8a28d3 fixed quiz stats page
60ce709 fixed views
d8c4437 fixedlesson bugs
70db28d Merge branch 'master' of https://github.com/SamLau95/cs61as-quiz-system into staging
1c08e60 set quiz time
948fa95 Merge pull request #102 from SamLau95/bugs
3a02ea3 fixed request bug
7e209d5 changed routes
b03b2eb Merge pull request #101 from SamLau95/sam/fix-timer
7d7a78a Fix ordering of JS
09a6d3a fixed routing
ac0163c Merge pull request #100 from SamLau95/bugs
ca07fa7 deletd methods
ef74619 what
4501501 fixed bugs
fb118ae fixed some bugs
3bd7c92 fixed staff method
c953983 routes
fe83daa Merge pull request #99 from SamLau95/tests
fcace95 tiny change
f8f651e Merge pull request #98 from SamLau95/tests
e127041 Fix typo
c9b7996 Better @avg assignment
b3d51c2 added added_info authorization
63665b5 fixed ability
6101bee moved things around
701b1e8 fixed login bug
65b1b36 added tests for importing students
f5903a9 moved avg
c3fc895 added quiz stats specs
5487fc5 fixed view and form
7757228 fix spec
e3b4ace refactoring
afca1ed refactoring stuff
38e4664 moved stuff around
48bd2c3 Merge pull request #97 from SamLau95/tests
cac2bdc allow staff to choose quiz for students'
bc33f3c removed method
a6b75a4 added routes
15774ba fixed spec
f5e0a05 moved things to one line
4ed3d58 fixed view logic
8b57a8b finished regrade tesets
5b5a2ee added regrade
dd32f89 added grade
f129d8b views and buttons
cc35038 fixed view
9b80fde fixed css bug
9e5f44e added show route
c8fef27 changed quiz bank to show question
74b3a6a refactored spec
0325897 fixed can_add bug
0ec896b deleted some useless methods
b44b8a8 it actually seeds now
b757b9b fixed rubric bug
b08c11e stupid seeds
a014652 bug
ebecf3e fixed bullet
6768af5 fixed some bugs
2cfac0f fixed new quiz bug
b293820 Merge pull request #96 from SamLau95/tests
0e73377 fixed destroy quiz request
4c5774c added method and spec for comments
dae9dcc fixed taken_quiz
077e942 bugs
79f915d fixed bugs
ea9ac83 finished refactoring
111df7d finished spec
3a74ffc fixed update method
b8047dc more routes
f94245f routes"
1a6cbe0 routing fun
bbb9d02 houng
426436d changed requests stuff
59c8ec9 routes
258bcde refactoring
e1aa8df refactor views
341a425 fixed basecontroller and destroy method
5a2eb19 added show method
6d9526b moved stuff around
5e21cfb fixed tests
b6ea9f4 changed routes
cf6b034 service object
32fea65 refactoring
0c6f2c8 whitspace
d2a302c Merge pull request #95 from SamLau95/refactor-user
1c8e4f8 Fix hound
0bcb082 Fix @quiz
a7f3ac0 No after hook
aa1c83d No after hook
bef8cca Fix params[:id]
45dc51d Don't use after hook
87a8183 Helper for better deny_access
7e45578 Don't authorize_resource
610d483 Fix auth
cda9c59 Remove unneeded controller
64e4597 Merge branch 'tests' of https://github.com/SamLau95/cs61as-quiz-system into refactor-user
30ea566 Minor changes and initialize spec
4e10734 hound
370be69 fixed up bugs and such
6620d6a merge
cf118f0 Merge pull request #93 from SamLau95/authorization-and-specs
839171d finished grading spec
a6deaaa added views
6d30632 Minor changes
f20a5cf Fix logins_spec
26ee58d Make sure callback works
625789c Remove edit_user_form
5918a54 Trim whitespace
4d33aec Validations for User and fix added_info
e430f69 Don't use form object to edit user
4056d50 Annotate
420419c Merge branch 'authorization-and-specs'
09d65f8 Spec for requests
5425698 Fix removing questions spec
f307fc4 Spec no longer needs to be pending
d12a875 Helper for authorization
29d1da0 Small renamings
a74a631 Fix namespace for quiz_locks_controller and authorization
3e5c32d Namespace for quiz_locks
757d66d Use base controllers
c6498d1 Use base controllers instead of cancancan
7c9af4d Cancancan gem
adeb1b8 Hound settings
75d3596 Fix unused argument
e13654e Hound config
954fc07 Fix quiz_spec
f1afef8 started grading quiz
bc4e5b6 change views
ca7ed79 added factories
89d9f16 changed views
7024f91 Spec for profile editing
c82e5b3 Rubric factory and fix question factory
08c6e54 Validate rubric present for questions
5545df2 Fix relationships controller namespace
58d0c20 fixed rlt bug
b4519e5 dont need added info
2625817 added more tests
09cbbda changed ability
c6bf54a refactored tests
fc15b52 added cancan to resources
6ca5431 Merge pull request #91 from SamLau95/routes
422de86 Use argument
d505421 Namespaced routes for quizzes
27f844c Namespaced routes for quizzes
88bccac Move controllers
a7e8add Namespace for regrades
7587e6e Fix method name
2172c5d Use new routes
692c50c New routes for grading and downloads
c936187 Use new student import routes
040a817 New import student routes
08729be REmove old method
3135d3f Update new namespaces
18b5c05 Better routes for students
8b82e9a Use new quiz_request routes
d526ded Scoped routes for quiz_requests
c9bddd2 Fix removing questions from quizzes
f39798a Better add path
462aa1a New add path
b354bab Refactor destroy
bd45837 Remove old bank route
5e49bab Use new bank route
f85a753 Stop breaking if no rubric
c108fd5 New routes
ae0ff92 Route for questions
ab00fd2 Merge master
7ec29c5 changed email from staging to live production
6705a54 fixed grading"
c57fd6b changed specs
d7231ba finished questions
0f08e16 added more specs
8e3e38d removed console log things
40dd095 Merge pull request #90 from SamLau95/tests
4579786 hound
6341c1d Staffs namespace
7da0abc Updates for new routes
40f582a pending
dae7cfb fixed takenquizzes
1fd0137 fixed forgery exception
e716cd3 started question creation tests
c9a9192 added rubic attributes
7b7e207 Fix case when question doesn't have rubric
ace7651 Remove old routes
b783117 Fix finish_grading
0e480fe Fix breaking method
aa1b5a1 finish_grading action
92772d0 Update with student_quiz_path
4632573 Better routes for student quizzes
f9a943b Better variable naming
f155967 Fix variable
4af2f97 Use new routes
a9cd9e9 Better routes for quizzes
207623c changed to button
ddfe5ec removed line
2cb340a whoops
28c876c fixed request bug
9a01c2f Merge pull request #88 from SamLau95/refactoring
60da3f8 Merge pull request #89 from SamLau95/tests
014a719 Merge conflicts
f08a6f1 Fix quotes
1893242 hound
93e18fe changed hound
ad1e902 changed gitignore
df2cc12 moved smtp
76dab4d added test email
a31fbf3 added errors
a177b6a changes
21d30a9 didnt work
e1fc955 keep trying:
7d35cf3 more tests
7105ff4 finish hound
8ad3b4f more hound
cfbcdc1 hound
e607f3a changed to staging for tests
21e7c3d added devise mailer
e6595eb Hound
665ae3f Refactor quiz_requests_controller.rb
715ead9 Use new routes
71da4b0 Update more routes
cb0c444 Update with new routes
bb00954 Better routes for quiz_request
654211f Delete registrations controller
b581556 Fix factories and login_spec
3354243 Spec for quiz taking
ca02de5 Trim whitespace
4953441 Trim whitespace
5e1b549 Update factories
cb8a970 Use poltergeist
9379894 make sure retakes cap at 9 for csv
8758fec removed method
9e050d0 added more quiz specs
4a45ec8 changed views
fcf4384 changed views
b1a9089 changed lesson to dropdown menu
c652a69 started quiz creation specs
f201b4e changed views
b9a4dcc finished model specs
29d53b1 changed method
9e37ff2 changed can add method
686acb9 fixed factories
9875b28 fixed quizzes in factories
91553dc added more specs
8b62201 started quiz models
7086347 removed methods
9e28fe5 changed all_lessons to lesson_values
b2589d6 replaced methods
ee30e70 changed lesson values
87f709f Launchy gem
b46cfe7 poltergeist gem
8e2491e added test file
e2f1785 Merge pull request #86 from SamLau95/refactoring
cb742c5 Fix quiz factory
243e84d Use pry/pry-debugger
b3e9c8b Merge pull request #85 from SamLau95/patches
a43df17 hound
fff96b4 fixed bugs and views
6f39c41 changed inject
fcdc049 Merge pull request #84 from SamLau95/patches
ff9cf11 Merge branch 'master' of https://github.com/SamLau95/cs61as-quiz-system
23a18b6 fixed downloading bug
7590504 more hound
8e927fc hound
56eca1d added views
00ce53c changed edit page
30b13fe added seeds
b7a4993 made class method
06ef708 annotations
8ec8920 comma
57236d7 assign_grader method
ed64c2e added column to taken quizzes
4c953ba added new column to taken_quiz
91b9a32 added methods
a503117 added sorting
d1736ef added default value to version
3b82863 Merge branch 'patches'
a781419 Merge pull request #83 from SamLau95/patches
46adabc added tabsize
5890097 added back security
889d6fc added autosaver with editor
2ff3cb0 no first/last name when you first make students
ed5eb21 no scope
6eca7c0 fixed bug
db51bfd routes
8797e8b Merge pull request #82 from SamLau95/tests
42b8cb0 Fix signed_in_student_spec
31c35ed Fix quizzes_spec
8f24064 Add comment
230a40a Fix student_dashboard_spec
f577558 Mark staff dashboard specs as pending
e997c3c Fix login_spec
b5c9330 Fix sign_in
6ada28d Update factories
0bf87d1 No guard in Procfile
c9f848d Rename to features folder
744c721 Merge pull request #81 from SamLau95/patches
7f3ff79 added security back
f6e1649 added text editor to showing student answers
f3a3e97 added text editor to all questions"
45244f6 right path to codeMirror
5141091 users cant edit other peoples profiles
a7c0635 removed old editor
8da1217 changed views
07f66e9 added alot of text editor stuf
e789e8f added codemirror
17067c0 sort by login
7f584ee download csv files
7516afe add initial password column
db4de88 paired submissions and questions correctly
9ea2a6c Added forgot passwords back
b2be68d more annotate
572c4c2 edit user stuff
2fc6946 retakes not viewable by students
91d2ce9 some yml stuff
dd872a7 Annotation
fcc9da1 force people to add info
05a1eec added info
9c9596f Added regrade requests
edf0cf0 Added points
625bf4a Moved method to application
1289ca6 added ordering
bdcd12d Merge pull request #80 from SamLau95/remember-quiz-input
6f2c271 Merge pull request #79 from SamLau95/bugs
9daa5d4 Remember quiz inputs
01bfbd1 more hound
e72d322 hound
83e94e5 added comments column
418830a Annotations
4442a79 add comments row
1096663 migrations
880ff8e remove forgot password
f95e34f whoops
641522b Merge pull request #78 from SamLau95/revert-77-bugs
6a0cd5e Revert "dependecies"
edb941b Merge pull request #77 from SamLau95/bugs
8b5f22c dependecies
2c14c44 Merge pull request #76 from SamLau95/bugs
bdd4eb7 bugs
1e9882b Merge pull request #75 from SamLau95/extra
b359d7b ds store
d9878e0 ignore dump files
96a5394 changed sorting order'
dc87046 listed students
e04febb changed to decimal (again)
e608537 Changed methods
f6d4e2f changed to decimal
282c4aa Fixed student views
faf7996 Merge pull request #74 from SamLau95/comments
c3bf62e doge
0783fa9 hound
575b70e fixed views
b22c45b validations
da0d4a7 views in
67f93cd Added comtroller
a936bc9 routes
1867eb6 add comments to db
c09f3ce moved stuff around
65d9d41 Merge pull request #73 from SamLau95/preview
1d0cf11 hound
78cd21a request cancelling
c3410c6 Finished logistics
3fbc18b grading logistics
0e58a91 Fixed bug
51213b0 put back commented out stuff
97c28bc Student answers shown on markdown
f83b59e Regrades show up
f884782 Add numbers
a6a082a deletions
99fd84d removed files
5d65fc4 Merge branch 'master' of https://github.com/SamLau95/cs61as-quiz-system into preview
f81c152 Merge pull request #72 from SamLau95/lesson
542b334 simple matching
e3abd4d added classes, js file
7da97ec users cant change login
a7b24ac Some views
adb1fd3 Students can't register anymore
c765a40 Merge pull request #71 from SamLau95/lesson
964b1c2 Changed requests
f6b65dd hound
e8e195e Changed lessons to string
da8f832 seeds
71309c8 change db
789cbc0 Merge pull request #70 from SamLau95/csv
e7a280d Hound
b92301e No routes actully, download only as csv
601c7ab routes
f5392fc Merge pull request #69 from SamLau95/import-students
30ac642 Display results of importing students
9ba26f8 Better student creation
96b6d99 Stop devise email validations
9d667f6 Don't validate emails
88c878e Import student action
43185b8 Links and import student page
267fd05 Route for importing students
ef16dad Merge pull request #68 from SamLau95/rubric
cc6c6ed More views
09bacde Add more views"
194a752 Fixed up some views
75bb1ba rubrics now have markdown
a7dec72 Update schema
27330e3 Merge pull request #67 from SamLau95/figaro
53835c5 Merge pull request #66 from SamLau95/rubric
57dc9a3 Ignore app config
6b77a71 Figaro gem
51fc972 Hound
4c821ce Can't delete questions on quizzes
3d7769b Fixed number for questions
6165b2f added pagination to questions
5b0ef96 Added editing and showing rubric
f4e322a Added seeds
39e1c36 Added more forms' :
3dccb1c Removed points column (what was i thinking) "
ebfe807 Added rubric forms
3d13677 added relationships
25baae2 Added rubric model and migations
68c04e1 Merge pull request #65 from SamLau95/back
342e138 Update questions_controller.rb
a0fb0f7 Update quizzes_controller.rb
0fe27f0 Added back buttons
e22c496 Fixed more bugs
1044e21 Fixed bugs
928ab71 Questions arent always created
85e1167 Merge pull request #63 from SamLau95/SearchingStudents
47e1b42 Update student.rb
ce0799c Update student.rb
336f6c9 Update student.rb
798173c Update student.rb
c78bb26 Update students_controller.rb
77ef8ee Update taken_quiz.rb
4504675 Update students_controller.rb
7a8f411 Update regrades_controller.rb
36925c8 Update quizzes_controller.rb
0939bb1 Update questions_controller.rb
73ef74a Merge pull request #62 from SamLau95/fixGrading
af84b2e Merge pull request #61 from SamLau95/bugFixes
a585cb5 Added extra search params
6ca1fe2 Fixed div issues
1d82a03 Finished search
eae7b5d Added pagination
2d8b0cb Added pagination
3465a54 Added question ehader
a65b211 Removed footer
74cfeef added paths
1875f40 Fixed routes, moved around html
e70d2ee Created files
fa49c5b Added routes'
ac29df9 navbar stuff
64004ef added terrible way to delete questions, todo later
9802dcd Added comments
ce7222e students can cancel requests
9c79e7e Fixed user issue
c4e50dc Added text warning
0949fe0 Renamed home button
7528831 Only TAs can log locked stuents in
2d10b2e hound
f622303 hound
689c398 hound
4735fd5 hound
c3f4c96 hound
1a7a67a hound
8b076c9 hound stuff
7106966 Finished regrade
458582b fixed view paths
8b63e64 Added undo method'
4337ab5 Added routes, and methods
1e7dd98 annotations
08d75bf More controller bug
25aefd4 Fixed view/controller bug
cd02e86 Added lesson field
e5e5cb1 Added routes, and links
6e9e6e6 Added Quizzes to grade part
631783e Deleted paperclip stuff for now
ff7b3c1 Added a finished grading field
11751e8 Added retake column
be034bb Added headers
b886cbb CHanged csv title and add lesson to first row of csv
d79ba88 Merge pull request #60 from SamLau95/bugFixes
5bec976 Fixed bug
24a3436 Added stuff back in
fa4e894 answers are now hilited
1c16e0e Merge pull request #59 from SamLau95/association
08753da fixed more hounds
7730a41 Annotations and fixed signup
8de16e0 Changed first/last name to string instead of text field
14da66e Fixing devise
69e5988 Finished views/controllers
6043c6e Views/controller for stats
84d5642 Added stats to routes/views
14f8fb9 Fixed up views"
75fc743 Clearing up hound stuff
5f7e830 Removed methods and replace with new model
11fd2a3 Small student bug
586c18e Made updating grades update the TakenQuiz model
5990496 Set up new model
2554446 Set defaults for grade
7471a75 Annotations
032b60a Added quiz/student assoc'
8d82617 Merge pull request #58 from SamLau95/csv
f937044 Retakes are submitted
b8db053 Merge pull request #57 from SamLau95/csv
bab08b3 Merge conflicts
755ca18 space
e81d4b0 space
4130d31 spaces
b25a866 Update quiz.js.coffee
cebafc2 Merge pull request #56 from SamLau95/login
11642d5 It works
ee659e9 Should work (testing)
3c2e434 Added retake to grades
9126421 Took out lesson params
5db91d3 Moved csv
0e64350 Fixed more bugs
b0e8e1e Fixed eager loading
012983b started method writing
c6a3b9e Added form
5281eb7 Started csv
d38abed Fixed not updating points problem
3841363 Update quiz.js.coffee
1c07739 Fixed spacing
6124c5a Merge pull request #55 from SamLau95/login
ab885e4 Fixed line length
32d90b7 Update devise.rb
60c4536 Update devise.rb
fc22791 Stupid dog
ae536a0 Finished logging in with devise
451f78f Users now sign in with login
99c3b0d Merge pull request #54 from SamLau95/Hilite
a5913c0 Readded security stuff
d94ef9e Changed font size and font
cb76965 Real time typing
962c276 Customized the js stuff
fde507c Ignore DSStore stuff
d883041 Students cant see solutions
2061cfe Merge pull request #53 from SamLau95/markdown
1b3c2b3 Use resizing textareas
227cc73 Remove old auto resizing
173f19d Autoexpanding textareas
ff88827 Quick Markdown reference
fc1ac05 Add some padding
19d9ecc No underline
4ba88e3 Fix nokogiri
0af0902 Use pygmentize instead of albino
61608d1 Syntax highlighting
d5e5883 Use albino gem
b98dc2f Use markdown wherever possible
a81947a Update markdown rendering
5ffac7c To markdown helper
57d6d03 Use redcarpet gem
bdd412e Merge pull request #51 from SamLau95/RandomBugFixesWOOHOO
183b2f1 Fixed creating questions
fcca157 Deleted stuff
3eb6127 Fixed grading quizzes bugs
1f8c5ec Make 0 grade ok
20b87fd Merge pull request #49 from SamLau95/RandomBugFixesWOOHOO
8189163 Fixed a retake bug
e8d1819 Added ctonroller stuff
c2ffa0b Moved toast
0a7d825 Merge pull request #46 from SamLau95/RandomBugFixesWOOHOO
4273f06 lol newline
04b4ba2 Fixed redirect, make only students now
544b17b Merge pull request #45 from SamLau95/script
975a2bd Fixed screen typing bug
2b58558 Remove the very helpful puts
83fd5bf Logging for debugging
7ba4866 Delete database_connection.rb
eafc3e3 Fix application.css
228cc46 Merge pull request #44 from SamLau95/script
def7cd1 Tab char
318b287 Uncomment lock
7f6c4fe If exit full screen ,lock
36ba065 Added fullscreen
7b527cd started full screen
94e8a1f Merge pull request #43 from SamLau95/Retakes
13af32f Fixed hound stuff
fbe0c0d Students can't request quizzes more than twice
d759b70 Fixed update bug
6f667b9 Finished retake
62d3ca1 omg punctuation
d435a6a Validation of questions and quiz forms
a87bdc2 Added model methods
8da55f2 Fixed routes
feff221 Fixed spaces
c071c36 Don't allow people to change lesson in edit quiz mode
267c5e2 Merge pull request #42 from SamLau95/Security
84859d6 blank line
c0d7e39 whoops commas
7b93ecc Check retake
9aec575 Changed text
cf204b7 Fixed more seeds
5d68847 Spacing
3020d88 Staff can enter in login/password to unlock
054078a Permissions
62c5b09 Fixed uniqueness problems
c1343e9 Fixed route bug
d8a4e84 Validations
88767b9 Students are screwed lol
b2a0be3 Kick students out if locked
a362080 Deleted needless js file
2bff409 Merge pull request #41 from SamLau95/addQuestionNumbers
8106835 tab spaces
3a0d79b Stupid doges
6f610f2 Can add question from bank
54da4bc spacing hounds
72ab7b9 allow staff to delete questions in bank
1a2989c Fixed question validation
44cab21 added question numbers
887b57e Parenthesis error
1f08876 Merge pull request #40 from SamLau95/requestRegrade
26e5f1a spaces...again
421e6a3 Fixed white spaces
3c4c0d0 Finished regrading
930c2ad Such doge
5a7746f Students can request a regrade
8018a32 Added more validations
62ca72d Added default false value to regrades
1dfbb79 Added model associations
8f5b89a Controller logic
d238383 Added routes
3c3ec56 Students can create regrade
44c033d Added more columns to regrade
931d16d Annotated stuff
745cc67 Add regrdes model
b3d9acc Don't set up assests and helpers
3d13aea Fixed cancan bug
4bc79ad Merge pull request #39 from SamLau95/showGrades
930663e Merge pull request #38 from SamLau95/addGrading
07cc517 Students can see grades
b63a222 See grade and comments
3f2eb7d Can see total score on staff dashboard
dcd0b14 Fixed take quiz bug
fe8544d Fixing up views
bcfe84b Added default to grades
68ce4f2 Finished grade, do touch ups later
036aa91 Started Grading
8f785c3 add lesson to grades
1a33695 removed grade views, grade on view's view
fee0263 Added grade routes
b3d41fd Stupid dog
f5ad020 fixed seeds
98a15bb Fixed relationships
9e41cc2 Merge pull request #37 from SamLau95/ChangeRelationship
6bc3971 Trailing whitespace
34362b7 Add to_s back to Question
240b097 deleted useless edit
caa2cba Hound stuff
775fd53 Merge conflicts
e6a1230 finished points
351718d Almost done
5a22b5f Still tweaking points/numbering:
0ac08ed Stupid dog
bf8592a Readded validations
76e832a Set default point values
1d91f5d Stupid spacing
9bef605 Patching up points/number
9abccda Remove more point things
57425e8 Edited seeds
f03590b Edited out points and number from models
32881fd Moved points and quesiton number to relationships
f192d56 Merge pull request #36 from SamLau95/UserSettings
7e1a350 Fix indentation
61d4694 Merge pull request #35 from SamLau95/addGrading
a81b8bc Merge pull request #33 from SamLau95/addOptionsAndSubmissions
d832a6d fix hound
778a92c Fix hound errors
8fa5eb6 Merge branch 'addGrading' into UserSettings
acc3777 Fixed hound stuff
14ba8ba Merge branch 'addOptionsAndSubmissions' into addGrading
0e96127 fixed long line error
7ace6e3 Added profile pg
c141008 Change order
59a61a2 Add users controller and routes
fcb3492 Add login to users
1b42052 Begin Grading
9ad28f8 Make questions come with solutions
17ac880 Added grade
50d4095 more seeds!
cd6abd5 Add comments
17a9984 Added grade model
24f9b4a Fixed quizlock and quiz submissions
cae89eb Fix seeds
94ff6d5 merge conflicts
046403e Merge conflicts
5b6eeaf Dropped options
929ccb3 hella deletions
17dd590 merge conflicts
a11f559 Seeded and annotated
adcc097 added drafts to questions
92facda Fixed some updating questions things
2e5f0f8 merge conflicts
a30c3b3 merge conflicts
92bde22 Merge pull request #30 from SamLau95/quiz-lock
44b0ddf Annotate
618eedb Change comment
bebc414 Need to specify class for question
73db01b Move models to folders
c7b535d Require models in subdirectories
87a372e Add index to options question_id
a4ad8b8 Remove making submissions from seeds
c33a74d Let student submit quiz
639482e Don't use turbolinks for take quiz
b8b52f7 Click submit after time runs out
73055fd Helpers
0513e82 Remove log statements
c8b3e1b Hit lock path with ajax
8b65bbc Fix authorization and respond to js
560ef3b Add unlock! method for quiz locks
c39c757 Fix naming
f928801 Default locked to false
106e2ab Push time_left to gon
0a8f192 Make time_left an integer
b05386f Make lock path visible to gon
099c0a6 Include gon in view
d7dcc74 Make sure question has type
28297a0 Add indicies for quiz_locks
ecff020 Remove quiz_id from question
9a40dee Use schema.rb instead of sql
ac8e915 Delegate locked? method
d169d21 Move subclass initializing into application controller
a4c86f1 Controller for QuizLocks
b7a03d7 Authorization for locking
afb0c50 lock! method for QuizLocks
52f1a3e Capitalization
b7597ae Add spec for student authorization
e302d67 Reword comment
8899b0b Comment for breaking method
6fa2154 Fix factories
139ebcd Remove old comment, use if
877a4c6 Delete old comment
1382c73 Validations for lesson and version
1e9a912 Use %w syntax
4fe506c Add gon
f7c770c fixed relationships issue
3535af2 Specify gon version
1cc9f49 Weird whitespace
c7ab331 Merge branch 'master' into quiz-lock
10da84a Use gon
d0981ed Helpers for expiry time
b601dc4 Javascript fix
ec6a879 ID for quiz form
6cf877e Merge pull request #27 from SamLau95/makeQuestions
4331559 Fixed mc
bf4099e Added some controller stuff
3a2a862 Better options for seeds
a54ab4b Merge pull request #29 from SamLau95/quiz-lock
14dcade Remove useless describe
12da30e No need for db:test:prepare anymore!
ba77d97 Show begin quiz only if quiz lock is present
1457ae5 Get quiz lock
72c9820 All requests are not approved
5053580 Use quiz lock instead of request
ac83581 Add validations on ids
bc1e9ae Fix to_s
898e075 Small refactoring
de963ae Fix failing tests
bfe5a36 QRs do not have approved attribute
6d3aae1 Renamed method
d1dde0f Fix typo
568ee4b Factory for quiz lock
cca0827 Use quiz lock to determine whether request approved
aab91ea Lock and destroy instead of approve
0dabb3b Use approve_and_lock!
9663df9 Association for student
5aa02bc Association and only pick published quizzes to give
037daef Approving request also locks student to a quiz
0f0b90d Add associations to quiz lock
d3964c5 Quiz 1 is not a draft
69ababb Annotate QuizLock
dc71255 Merge pull request #28 from SamLau95/rails-ruby-version
6dd5546 Merge branch 'master' into rails-ruby-version
5a76faf Migrations
d02a6e2 Update Ruby and Rails version
dc1e5f2 Fixed strong params
4f28521 Added validations and method
1ecc0ba added associations
0d5e8eb changed views, models, added some methods
38e5cea made questions actually show up
3b4d38f added routes and views
dc39f1e added lesson to questions
200dadd Moved to a partial and added new questions to the staff index
e0c82b9 Merge pull request #26 from SamLau95/viewStudents
5721529 can view quizzes and student answer
6f6ff0e added seeds for submissions and fixed show page link
bf030a9 Fixed link problem (whoops)
235ff1e Started student dashboard
9c8628c Merge Conflicts
77681f0 Merge pull request #25 from SamLau95/seeQuestion
e5e3ae9 Started specs
e54f6c2 Got things to show up on the quiz (mc/checkbox questions)
ac49682 Added selection inputs and got rid of n+1 query
6063f26 added options function to get list for selection
fe6d668 Added options to submissions
5834ed6 Edited out testing parts
028c147 Sigh
df0260d Added partials for questions.
65dc6df Merge pull request #24 from SamLau95/delete-quiz-request
5c0347a Spacing
d22f60a Destroy quiz request after student starts quiz
3fa8466 Use quiz request instead of just lesson
e2cab56 Annotate
58d4bb5 Specs for quiz request destroying
80fc67f QuizLock model
126aeae Migration to add retake option to quiz requests
6d3faba Not using ruby schema anymore
a302ac0 Merge pull request #23 from SamLau95/take-quiz-route-hotfix
26a9680 Fix breaking route
6ca6e8b Merge pull request #20 from SamLau95/dynamicforms
47eb1b7 Delete unneeded files
1738802 Fixed small issues
c0fe037 Merge conflicts
027ce44 Ajax stuff for delete
a22c406 User can delete comments
e803505 Fixed strong params
3eac45a Everything works....except strong params
2f6baa6 Added forms for question and options, can add more options
efe7d3f Changed params
7aff013 Off by one errors
d481846 Deleted unecessary files
23f224b Add views for quizzes and stuff
cf0151a Added STI for questions
21f31f9 Merge pull request #22 from SamLau95/quiz-taking
c114348 Add todo
8fdc29d Route alignment
455e8a0 Spec for showing link
e90d9a3 Show button only when approved
91e13a3 Added show pages and extra routes
dac623a Use new take path
fddb546 Delegators for student
f80c8cc Authorization for take
ed78e63 Use current user's request instead of params
3e45c9a Change take route
a0ac671 Removed hash, attempting to try options model
bd39efb Setting up validations and routes
9105c43 Added options seeds
f37efb3 Deleted array, added hstore for options
cf22414 Spec for approved quiz request
187c5cd Fix typo
ac1a775 Changed type to format
86d07f2 Merge pull request #21 from SamLau95/request-approval
7fbd3ec Flash messages on success
cc246b9 Make a request in the seeds
d6450ae Cancel quiz request link
67d1b6a Spec for deleting quiz request
d49bc1e Controller for requests
7f520b5 Link for approving request
8b6cf1b Routes for approving requests
903e259 Specs approving request
0c56b2a Only show not approved requests
61cecab Scope and approve! method
70d1efa stupid whitespace is stupid
20b9f19 Added type and options to pg
541b44a Display requests
f04b468 Shuts up rubocop
93d9d4c Consistent authorization for controllers
b086f35 Spec for displaying quiz requests
e7c4fa1 Use to_s helpers
527da69 to_s methods
d4f116e Annotate
22a106e Add approved attribute to quiz request
a05f9b3 Factory for quiz request
ee7de82 Use expect syntax
7f3bd16 Deleting questions
a87e2b4 Merge conflicts
45fd5db Merge pull request #19 from SamLau95/make-quiz-request
7aa4558 Sort by lesson
931e327 Spec for quiz requesting
3f10b96 Helpers for specs
3058351 Ensure database gets cleaned
dedeef4 Render conditional
6914dd9 Spacing
511a0e1 Fix authorization
513617b Authorization for student dashboard
0751673 Make request action for quiz controller
4ea602c Make quiz request available in view
9f291de Fix url for quiz form
155a606 Lesson number instead of quiz id in routes
99ffecc Annotate quiz request
d154491 Better redirect after cancan exception
514a977 Renamed partial
f5f880b Added default points to questions, renamed draft to is_draft
c7b9c65 Spec for not signed in users
f610880 Factories for quiz and questions
872bc92 Utility methods
bb3748b Added draft options to edit quizzes
2452f24 Test for login
8ccaf0c Fix typo
4ee2296 Add draft to quizzes
e5db018 Stop running tests twice
479c535 Slience i8 warning
a17d108 Save quiz attributes after edit
335ea99 Stop rubocop from yelling at me
3973136 Config capybara and routes
847e76b Comment for student model
fe1b17e Initialize factories
da037c4 Config
25674f3 Use zeus with guard
857fb88 Fix factorygirl issues
07396ce Added quiz_type model
9b05142 Staff can add questions and edit them and make new quizzes
2471a23 Configure databsae cleaner
3026663 Setup database cleaner
53113b1 Watch rspec tests
6d0718f Use database cleaner
4fc4acc Remove empty specs
67828ec Start zeus with foreman
30edf9c Commented out test watching for now
4004a34 Use capybara
e0d1461 Add zeus, capybara, guard-rspec
e893889 Rem test folder
b5ecb9d Initialize rspec
38a80fb Link to process quiz request
255af2d Route for processing request
5d32683 Make request action
5418535 Rename quiz number to lesson
51d9550 Student should only have one quiz_request
0381bea Quiz request belongs to a student
a4a1c5e Rename fields in quiz request
11b3ce6 Merge branch 'admin-edit-quizzes' into make-quiz-request
c407be9 Helpers for getting lessons and picking a random quiz
a143990 Student dashboard should get the quiz lessons
5f306cf Dashboard should show lessons only
88d8a56 Routes for making quiz request
87ee283 Really added link to new quiz form
7dad277 Users can submit questions with blank forms
6944f7d Merge pull request #16 from SamLau95/admin-edit-quizzes
1c1cc94 Check to make sure submission was saved
39160f8 Update readme
450b532 Have question id be in form
01c4152 Form should update Questions on save
ee62de4 Use new method names
24dc44e Rename method
523db8d Fix style
f1e34b6 Fix gitignore
2aa70c7 Merge conflicts
c2aab99 Removed db.yml
5596e4d Procfile for production
fb6c63c Use different Procfile for development
2c7c942 Fixed gitignore
821aff8 Lame Timer
00ab36f Merge pull request #14 from SamLau95/procfile-dev
b98c42f Auto resizing textareas
a369e58 Use form object in views
b249efa Validations for quiz form
b91590c Quiz form for quiz editing
44a9f91 Default ordering for questions
322903d Merge pull request #12 from SamLau95/timer
aa78551 Use form object for editing quizzes
a7ac975 Comment for Question model
04b316c Annotate
38f2720 Initialize edit quiz form
03c8b7a Stop rubocop from yelling at me
74722a1 Annotate models
4ef03f5 Fix toastr alerts
1b24688 Removed db.yml
8dfa50a Procfile for production
2e848c1 Use different Procfile for development
ebcbe39 Merge pull request #13 from SamLau95/reform-and-quiz-submissions
44e5445 Use new form object name
22c3cfe Rename to take quiz form to be more explicit
b41c76b Use new submissions in params
112c896 Use new submissions for quizzes
d6b9a6f Use form instead of partials
c4ee62f New submissions method for quiz
cc5a1fc Use quiz form object in controller
1de9b6f Question content delegator
67e403c Quiz Form class
4bb504d Watch forms folder
952a528 Use rubocop
d69ad48 Use reform gem
8dd83db Fixed merge conflicts
dd11074 Fixed gitignore
4878899 Lame Timer
2e00f8b Merge pull request #11 from SamLau95/live-reload-and-take-quiz
be4927f Update take quiz, ajax for submission saving
c088ec7 Full name method for question
76dc00d Update quiz controller
852befb Question form
764ccc9 Routes for submissions
d0ec2c5 Enforce authorization on all controller actions
a10f38f Guard controllers and routes
4aa3fd4 List quizzes in student dashboard
fcaccf3 Require false for guard
2bac899 Merge pull request #10 from SamLau95/live-reload-and-quiz-edit
99b2c47 Edit question partial
e7710ba Edit view
99f9e27 No show route for quizzes
bcba870 Link to quiz edit
2286fad Full name method for quizzes
4ca64c7 Show route for quizzes
46e54b0 Start guard with foreman
ad299a1 Guard assets
e90ff66 Versions for foreman and puma, livereload
c48b0d3 Merge pull request #2 from SamLau95/initialize-staff-dashboard
5f5b9ce Delete wercker.yml
fc8735a Use student names in dashboard
6459a91 Seeds with user names
c1150cd Full name method
40e4a52 Add first/last name to users
a2634d5 List quizzes and students
a3434c6 Routes for students
4cbace4 Another quiz in seeds
8f8d049 Instance vars for views
18f48fa Update question field form
f7048f9 Add quiz request associations
024b306 Authorization
aed5088 Authorize student dashboard
63a84b1 Submit logic
3f0179a Add access denied message
60d5d89 Quiz Request model
64c3ef7 Add type to user
b089fdc Fix id
1475b23 Use 0 threads minimum
f6b34a1 Use env port var
e6453b7 Update wercker.yml
0e7b652 Move wercker.yml
2254c70 Use database connection reaper
3c05c17 Create procfile
83a1b21 Use puma, foreman
6cd5fec Update wercker
4315057 Add Wercker
1ffc7ab Set devise secret token
372d9be Set devise secret token
1c572f3 Ignore .env
4c7e7a5 Use dotenv gem
f4e3b31 Question field partial
abe0585 Take quiz form
8cbde05 Build submissions
e27ce8b Fix event listeners
61c23a8 meta_request gem
7321f4b More questions for quiz 1 in seeds
8eb7168 Slight change to page change message
78b8449 Stub question spec
1dfae9d Update seeds
28f0235 Quiz taking form
370fac7 Log in/out in header
dc17083 Quiz controller actions
e427cd1 Routes
272456e JS to detect focus change
59bf38b Points to question, submission belongs to quiz
3397e90 Dependent destroy, ability.rb
b204a3c Annotate models + specs
7d63d7a Change text to content
6d6b1ec Initialize bullet
9f3cb91 Make necessary columns unique/indexed
fec1f55 Add associations
55f8dc3 Rename model
59c3a77 Stub specs for models
6058d9d Stub views for dashboards
0320db0 Update schema and seeds
1088802 Models for quiz and quiz submissions
906ec95 Migrations
b5a6b1d Student dashboard controller
32b14c7 Simple form initialize
42f455e Slim form template
8334352 Header and footer views
8fbc31f Convert view to slim
3ac2ab3 Redirect after signin
814728a Add gems
5383319 Foundation and toastr
c052ccb Initialize devise, models, secret token
f1763b5 Update gemfile + database
35e1435 Update readme
53b934d Initialize app
