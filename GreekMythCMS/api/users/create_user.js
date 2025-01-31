document.addEventListener('DOMContentLoaded', async () => {
    const form = document.querySelector('.form-container form');
    const createButton = document.querySelector('#Create');
    const cancelButton = document.querySelector('#CancelCreate');

        createButton.addEventListener('click', async (e) => {
            e.preventDefault();
            const username = santizeInput(form.usernameCreate.value) ? santizeInput(form.usernameCreate.value) : "";
            const email = santizeInput(form.emailCreate.value) ? santizeInput(form.emailCreate.value) : "";
            const password = form.passwordCreate.value;
            const confirm_password = form.confirmpasswordCreate.value;
            const image = form.imageCreate.files[0] ? form.imageCreate.files[0] : "";
            const bio = santizeInput(form.bioCreate.value) ? santizeInput(form.bioCreate.value) : "";
            
            const formData = new FormData();
            formData.append('username', username);
            formData.append('email', email);
            formData.append('password', password);
            formData.append('confirm_password', confirm_password);
            formData.append('image', image);
            formData.append('bio', bio);
            formData.append('type', 'createUser');

            const response = await createRequest(users_url, formData, token);

            if(response.status < 300){
                createButton.disabled = true;
                window.location.href = `navigate/users.html?updated=${true}&message=${response.message}`;
            } else {
                console.log(response);
                checkErrors(response.error);
            }
        });

        cancelButton.addEventListener('click', () => {
            window.location.href = 'index.html';
        });

});