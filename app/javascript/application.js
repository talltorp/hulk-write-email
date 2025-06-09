// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// app/javascript/application.js
document.addEventListener("turbo:load", function() {
  const turnstileElement = document.querySelector(".cf-turnstile")

  if (turnstileElement && window.turnstile) {
    const siteKey = turnstileElement.dataset.sitekey

    window.turnstile.render(turnstileElement, {
      sitekey: siteKey,
    })
  }
})