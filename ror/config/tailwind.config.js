const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './public/*.html',
    './app/components/**/*.rb',
    './app/components/**/*.html.{erb,slim}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/views/**/*.html.{erb,haml,html,slim}',
    './config/initializers/*.rb'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Montserrat', 'Inter var', ...defaultTheme.fontFamily.sans],
        logo: ['Finger Paint', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        blue: colors.blue,
        green: colors.lime,
        red: colors.rose,
        yellow: colors.amber,
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
