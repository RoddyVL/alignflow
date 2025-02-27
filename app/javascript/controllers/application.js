import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("turbo:load", function() {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

  // Si tu utilises Turbo, assure-toi que la requête PATCH inclut ce jeton CSRF
  const updateHeaders = () => {
    document.querySelectorAll('form[data-turbo="false"]').forEach(form => {
      form.addEventListener("submit", (event) => {
        const formData = new FormData(form);
        formData.append("authenticity_token", csrfToken);
      });
    });
  };

  updateHeaders();
});
