# Flutter TODO App

## Features
#### Basic
- [x] Add, Edit, View and Delete Task
- [x] Mark as Low, Basic and Important 
- [x] Screens: todo list, add/edit/view todo screen
- [x] Swipe on item to Completed/Delete   
- [x] Display of completed todos
- [x] Work with backend is implemented, data is sent/received from the server
- [X] Offline-first mood
- [x] Organized saving data to disk using a SQFLite
- [x] Implemented work with Firebase Analytics. It collects analytics on events: adding, deleting, completing, transitions to the screen
- [x] Connected and configured Firebase Crashlytics
- [x] Internationalization
- [X] State-management and DI implemented using `flutter_riverpod`
- [x] App icon added <img src="https://github.com/olndl/todoapp/blob/develop/assets/icons/icon.png" width="25" />
- [X] Implemented Navigator 2.0
- [X] Supported deep link that opens the screen for adding a new case ->
`adb shell am start -a android.intent.action.VIEW     -c android.intent.category.BROWSABLE     -d "http://example.olndl.com/%7B%22path%22%3A%22ListTodoSegment%22%7D/%7B%22path%22%3A%22CreateTodoSegment%22%7D" com.olndl.todoapp`
- [X] Night theme support
- [X] Unit-tests

## APK
- [Download the latest version of the app]()


## Screenshots
<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/ru_list.png" width="250" />
      </td>
      <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/add_todo.png" width="250" />
      </td>
       <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/view.png" width="250" />
      </td>
       <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/calendar.png" width="250" />
      </td>
    </tr>
   <tr>
    <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/long_todo.png" width="250" />
      </td>
      <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/check.png" width="250 height="100" />
      </td>
      <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/dismis.png" width="250" />
      </td>
      <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/long_dis.png" width="250" />
      </td>
    </tr>
  </table>
</div>

## Remote Config (eng/rus device language)
<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/todoeng.png" width="250" />
      </td>
      <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/eng_add.png" width="250" />
      </td>
    </tr>
   <tr>
    <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/ru_list.png" width="250" />
      </td>
      <td style="text-align: center">
        <img src="https://github.com/olndl/todoapp/blob/develop/assets/screens/add_todo.png" width="250" />
      </td>
    </tr>
  </table>
</div>

## Packages Used

- `dio` to work with Http client.
- `freezed` - code generator for data-classes
- `flutter_riverpod` for state management.
- `sqflite` and `path_provider` to support local storage.
- `firebase_crashlytics` and `firebase_analytics` to monitor failures in runtime.
- `firebase_remote_config` lets change the behavior and appearance of app
- more at `pubspec.yaml`

