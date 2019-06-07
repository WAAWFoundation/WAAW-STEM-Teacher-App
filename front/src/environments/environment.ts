// This file can be replaced during build by using the `fileReplacements` array.
// `ng build ---prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  application_name: 'Waaw Web',
  api: {
    version: '0.0.1',
    url: 'https://waawapi.herokuapp.com',
    // url: 'http://0.0.0.0:4070/',

    asset: 'https://s3-eu-west-1.amazonaws.com/edureck1/waaw'
  }
};

/*
 * In development mode, to ignore zone related error stack frames such as
 * `zone.run`, `zoneDelegate.invokeTask` for easier debugging, you can
 * import the following file, but please comment it out in production mode
 * because it will have performance impact when throw error
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.
