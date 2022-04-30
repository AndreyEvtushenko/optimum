# Optimum
It's a pet-project web-app that is designed to help manage consumed food nutritional value

# Technologies
Stack: Vue 3 + Express + MySQL  
Frontend: Vue 3 Composition API, Pinia 2, Vue Router 4, Vite 2.8  
Backend: Node.js 16, Express.js 4  
Database: MySQL 8

Date-picker: https://www.npmjs.com/package/vue3-datepicker  
Mysqljs for node.js: https://github.com/mysqljs/mysql

# What it can do
There are four pages:
1. Main page. Here you can specify eaten food and it's weight for particular date. App will count the rest
![main page smaller](https://user-images.githubusercontent.com/23217839/165689899-ea432563-47c9-4697-a938-f7d907fabec3.gif)

2. Products page. On this page you can add new products as long as show, edit or delete already existing
![products page](https://user-images.githubusercontent.com/23217839/165693876-b131b788-9151-4d47-a746-b9855407f6bf.gif)

3. Cooked page. On cooked page you can add your new cooked thing along with ingridients. Also, you can look through your previous culinary masterpieces, their ingridients, edit them, delete or even use them as basis for the new ones
![cooked page](https://user-images.githubusercontent.com/23217839/165726870-06fadb31-69a1-42f7-94bc-79ff31fc2bcc.gif)

4. Total page. Shows total date statistics for period
![total page](https://user-images.githubusercontent.com/23217839/165700683-2b1fffe1-00d7-4abd-a622-52aa8b48d775.gif)

# How to run this app
Set up database using backups from database_backup folder  
In the client folder and in the project root folder run this command:

```
> npm run dev
```

In your browser use this address:
```
localhost:3000
```

# Plans for future
Mobile version  
Authentification  
Multi-user system implementation  
Proper error-handling  
Better design  
More functional UI  
More reliable interaction with database  
Custom dropdown "How many to show" list on the cooked page and better interaction with search input  
More functions, such as morning body weight input, supporting caloric content  
More flexible editing and deleting of records  
