document.addEventListener('DOMContentLoaded', async () => {
    const form = document.querySelector('.form-container form');
    const createButton = document.querySelector('#Create');
    const cancelButton = document.querySelector('#CancelCreate');

    const fetchUsers = await postRequest(users_url, token);
    const userData = fetchUsers.data;
    console.log(userData);
    
    const usernameOptions = document.querySelector('#usernameCreate');
    const groupOptions = document.querySelector('#groupCreate');

    usernameOptions.innerHTML = ` <option value=''>Select</option> ` + userData.map(username => `
        <option value='${username.user_id}'>${username.username}</option>
    `).join(' ');

    usernameOptions.addEventListener('change', async (e) => {
        const userId = e.target.value;
        if (userId) {
            const fetchGroups = await getRequest(groups_url, userId, token, 'getGroups');
            const groupData = fetchGroups.data;
            console.log(groupData);

            groupOptions.innerHTML = ` <option value=''>Select</option> ` + groupData.map(group => `
                <option value='${group.greek_id}'>${group.name}</option>
            `).join(' ');
        } else {
            groupOptions.innerHTML = `<option value=''>Select</option>`;
        }
    });

    cancelButton.addEventListener('click', (e) => {
        e.preventDefault();
        window.location.href = 'navigate/posts.html';
    });

    createButton.addEventListener('click', async (e) => {
        e.preventDefault();
        const title = form.titleCreate.value ? form.titleCreate.value : "";
        const content = form.contentCreate.value ? form.contentCreate.value : "";
        const userId = form.usernameCreate.value ? form.usernameCreate.value.toString() : "";
        const groupId = form.groupCreate.value ? form.groupCreate.value.toString() : "";
        const formData = new FormData();

        formData.append('title', title);
        formData.append('content', content);
        formData.append('user_id', userId);
        formData.append('greek_id', groupId);
        formData.append('type', 'createPost');
        

        const response = await createRequest(posts_url, formData, token);
        if(response.status < 300){
            createButton.disabled = true;
            window.location.href = `navigate/posts.html?updated=${true}&message=${response.message}`;
        } else {
            console.log(response);
            checkErrors(response.error);
        }
    });
});