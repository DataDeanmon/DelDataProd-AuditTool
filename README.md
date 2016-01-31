# Introduction
This repository has been created in support of the Coursera Data Science Specialisation course - Delivering Data Products.

A simple Shiny application demonstrating the learning outcomes of the course has been created and deployed to RStudio's server. The Shiny app is located [here](https://datadeanmon.shinyapps.io/AuditSelectionTool/).

The "pitch" presentation to senior managers in a hypothetical revenue collection agency to demonstrate the advantages of the app is located [here](http://rpubs.com/DataDeanmon/AuditSelectionTool).

This app uses the "audit" dataset from the "rattle" package.

# How to use
The app is designed for use by an employee in an revenue collection agency with the responsibility of selecting taxpayers for audit. To achieve this aim, the app use a predictive model to evaluate the likelihood that an audit of a taxpayer with certain characteristics will result in a productive audit.  This likelihood is based on the results of previous productive and unproductive audits undertaken by the agency.  

A productive audit is one which identifies errors or inaccuracies in the information provided by a client. A non-productive audit is usually an audit which found all supplied information to be in order.

The user is required to enter details (i.e. Age, Gender, Income, etc) regarding a subject taxpayer, using the user interface on the left hand side of the app.The results of the predictive model, based on these details, is shown on the main screen (i.e. whether to audit or not). The app also plots the results of previous audits based on the details of the subject taxpayer entered by the user.  These plots assist the user to understand the model's decision to audit or not to audit a specific subject taxpayer.   
