document.addEventListener('DOMContentLoaded', async () => {
    const form = document.querySelector('.form-container form');
    const createButton = document.querySelector('#Create');
    const cancelButton = document.querySelector('#CancelCreate');

    const fetchUsers = await postRequest(users_url, token);
    const userData = fetchUsers.data;
    console.log(userData);
    
    const creatorOptions = document.querySelector('#creatorCreate');

    creatorOptions.innerHTML = ` <option value=''>Select</option> ` + userData.map(username => `
        <option value='${username.user_id}'>${username.username}</option>
    `).join(' ');

    createButton.addEventListener('click', async (e) => {
        e.preventDefault();
        const userId = form.creatorCreate.value ? form.creatorCreate.value.toString() : "";
        const name = form.nameCreate.value ? form.nameCreate.value : "";
        const description = form.descriptionCreate.value ? form.descriptionCreate.value : "";
        const image = form.imageCreate.files[0] ? form.imageCreate.files[0] : "";
        const type = "createGroup";
        const formData = new FormData();

        formData.append('creator', userId);
        formData.append('name', name);
        formData.append('description', description);
        formData.append('image', image);
        formData.append('type', type);

        const response = await createRequest(groups_url, formData, token);
        if(response.status < 300){
            createButton.disabled = true;
            window.location.href = `navigate/groups.html?updated=${true}&message=${response.message}`;
        } else {
            console.log(response);
            checkErrors(response.error);
        }
    });

    cancelButton.addEventListener('click', (e) => {
        e.preventDefault();
        window.location.href = 'navigate/groups.html';
    });
}); 