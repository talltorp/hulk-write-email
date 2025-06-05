const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        headline: ['Bangers', ...defaultTheme.fontFamily.sans],
        hand: ['Nanum Pen Script', ...defaultTheme.fontFamily.sans],
      },
      keyframes: {
        shake: {
          '0%, 100%': { transform: 'translateX(0) rotate(0deg)' },
          '10%': { transform: 'translateX(-2px) rotate(-1deg)' },
          '20%': { transform: 'translateX(2px) rotate(1.5deg)' },
          '30%': { transform: 'translateX(-3px) rotate(-0.5deg)' },
          '40%': { transform: 'translateX(1px) rotate(1deg)' },
          '50%': { transform: 'translateX(-1px) rotate(-1.5deg)' },
          '60%': { transform: 'translateX(2px) rotate(0.5deg)' },
          '70%': { transform: 'translateX(-2px) rotate(-1deg)' },
          '80%': { transform: 'translateX(1px) rotate(1deg)' },
          '90%': { transform: 'translateX(-1px) rotate(-0.5deg)' },
        },
      },
      animation: {
        shake: 'shake 1s cubic-bezier(.36,.07,.19,.97) both',
      },
      colors: {
        'hulk-green': '#c0c75a',
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
