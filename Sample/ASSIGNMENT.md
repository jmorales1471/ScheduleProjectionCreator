# Project 4: Static Web Site Design

Your team must meet and choose four project manager's for this assignment. The project managers roles are:

* The overall project manager will coordinate and check quality for the entire project.
* The implementation project manager will coordinate and check quality for the coding tasks.
* The documentation project manager will coordinate and check quality for documenting code.
* The testing project manager will coordinate and check quality for testing code.

All team members must participate when deciding on which four different team members to assign to the roles. Though, the team member who plays the role of the overall project manager must be a team member who already has the most experience with the Ruby language.

The responsibility of a manager is to oversee and help coordinate work accomplished by the group. A project manager must participate in the implementation of the project as well as perform managerial tasks.

The role of a manager is **_NOT_** to tell anyone what to do or boss anyone around. Team members are **_NOT_** to dump work on a manager or assume that a manager will do their work for them, especially if you have procrastinated or have not studied the course material well. You as a team member are responsible for the work you take on and to report to **_ALL_** other team members on the progress and quality of your work.

## Individual Assignment

**BEFORE** starting the group portion of the project **_EACH_** team member must individually accomplish the following:

* Thoroughly study the lecture notes on Git and Ruby
* Accomplish any tutorials and related reading material indicated in the _[Resources](http://web.cse.ohio-state.edu/~shareef.1/3901.au17/resources/)_ section of the course website
* Also, look over the reading material in the "Software Engineering" portion of the Resources section of the course website

**_Important Note:_** A team member who is ill prepared before starting the group portion of this assignment because s/he has not sufficiently accomplished the individual portion of the assignment above cannot use this as an excuse for that team member to contribute less work on the project. Those team members who are ill prepared **_MUST_** put in more time and effort than other team members to prepare in order to be able to contribute **_EQUALLY_** with all other team members. In addition, those team members that are well prepared **_MUST_** work to help those that need to catch up with the material.

It is the responsibility of **_EVERY_** team member to ensure that each team member contributed equally to the final solution submitted to the graders.

Your project will be graded not only on your group's solution but also on how well your group worked together to arrive at your final solution. An imbalance of the work load will result in a lower grade for the project regardless of the quality of the solution.

## Group Assignment

* Your team must meet face-to-face each week with all team members present on the agreed upon day and time your team members indicated to me in your Project #1 submission.
* Your team should have additional face-to-face meetings. You should also determine additional channels of communication with team members since you will need to integrate your work with others.
* Your team should plan and allocate time to integrate your work well before the deadline. I suggest that the team work with the overall project manager to set team deadlines early so that all team members know the status of everyone's work. Create a schedule that all team members can agree to adhere to and work to achieve towards.
* Use your team's private repository on GitHub to help manage the development of your team's solution. We will provide this private repository for your team in our GitHub organization called cse3901-osu-2017au.

### Static Web Site Design

The CSE department maintains a [directory](http://www.cse.osu.edu/about-us/faculty) with links to each faculty member's web page. Some of these pages are very simple, others are more complex. But few (if any) are HTML 5 or CSS compliant, and all could use some help in terms of design.

<p>For this project, your task is to <strong>redesign</strong> (and improve!) <em>one</em> professor's web site.In particular, you are asked to redesign either Prof. Davis'site (<a href="http://www.cse.osu.edu/~davis.1719">~davis.1719</a>) or Prof. Stewart's site (<a href="http://www.cse.osu.edu/~stewart.962">~stewart.962</a>).</p>

The final result should conform to the following requirements:

1. Professionalism. You should be proud to demo your completed project to your parents and to the faculty member in question!
2. Fidelity. While the style and organization can be completely different, all the factual information in the redesigned site should be accurate (i.e., taken from the original). Conversly, the information in the redesigned site should be relatively complete (i.e., all/most of the information in the original site can be found in the redesigned one).
3. Size. There should be at least 3 separate pages, with links between them.
4. Content. There must be at least one table and at least one image.
5. Technology. The site should be generated using Middleman. Use only core HTML and CSS (including markdown, ERb, YAML, etc). Do not use, however, any JavaScript or any web design frameworks such as Bootstrap or Foundation. If you are unsure whether a particular technology is permitted for this project, ask.
6. Validity. Your completed project should be fully validated HTML and CSS.

Don't worry about making your redesigned site cross-browser compatible. Just make sure it looks good in (the virtual machine's) Firefox browser.

## Grading

* 78% Implementation
You will be graded on the design, look, and feel of your website. You will also be graded on how much of the HTML and CSS functionality provided in HTML5 and CSS3 you used that goes beyond the most commonly used functionality. For example, the use of headers and footers, navigation bars, etc.

* 10% Balanced work load
The graders will determine whether the work load for your team's solution was equally balanced between the team members. Your team must indicate this to the grader via your documentation (see below) and Github repository contributions. The activity on your Github private repository must clearly indicate that all team members have contributed to the repo. Activity that indicates only one or two members submitting work will result in a reduction in points.
<br>
If team members develop source code in a [Pair Programming](http://en.wikipedia.org/wiki/Pair_programming) scenario then documentation must clearly indicate only the team member(s) who substantially contributed to the source code. Making minor changes or suggestions does not count as _substantial_ contributions. If one team member contributed more than the other team member in the pair, then your documentation must indicate this. If a team member simply watched the other team member program or contributed very little, then do not indicate this team member as a contributor to the source code.

* 5% Code Structure
You will be graded on the readability, organization, and structure of your HTML and CSS code. For example, it is a good idea to place your CSS code in separate .css files.

* 5% Documentation
Your team must document your solution well. Ensure that documentation is consistent across all source code.
<br>
At the top of each file you must indicate which team member created the file and the date of creation. Whenever a team member edits a file to add functionality or perform debugging that team member must add their name at the top of the file and indicate the date of their changes and a single line description of their changes. The top of the file must also contain a short paragraph that provides an overall description of the contents of the file, e.g. what problem you are solving.
<br>
Each module (e.g. Ruby function) must indicate the name of the team member that created that function and the date. Each team member that edits the module must add their name to the list of authors and indicate the date of their changes and as well as a single line description of their changes. In addition, each module must have at least a single line comment that describes the functionality of the module.
<br>
Use single line commenting where appropriate but not excessive.

* 2% readme file (see below)

## Submission
<p><em>Individual submission</em>: Download a peer evaluation form from your
Carmen account, print out the form, and fill out with a pen. Complete this form individually only, i.e. not as a group.
Submit this form in class on the next class meeting after the due date. Please staple, if needed! </p>
<p><em>Group submission</em>: The graders will retrieve your work (<em>readme</em> plus your solution) from your team's Github private repository 
provided for you under the course's organization cse3901-osu-2017au. All team member's work must eventually be merged 
into a final committed version in Git. The <em>readme</em>  contains the names of each project manager and states what 
each team member <em>specifically</em> contributed to the final submission. <em>For the latter, only report on 
contributions that made it into to the final solution</em>. Clearly indicate which team members performed testing and 
to which portions of the solutions. Also include any instructions to the grader as to how to execute the code.</p>
<p>You will submit your project by simply
creating a git <em>tag</em> called "submission" and then pushing
this new tag to your shared repository. (A tag is basically
an immutable branch.)</p>

<p>That is:</p>

<pre><code>$ git tag -a submission -m "completed project"
$ git push origin submission
</code></pre>
<p><strong><em>IMPORTANT</em></strong>: Your repository must include a <em>README</em>
text file containing the name of each project manager and a
description of each team member's <em>specific</em> contributions
to the final submission. Clearly indicate each team member's
contributions to development, testing, documentation, etc.
Also include instructions for the grader as to how to
execute your program.</p>
