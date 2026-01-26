<script lang="ts">
  import { onMount } from "svelte";
  import { fade, fly } from "svelte/transition";

  let isDark = false;
  let isLoaded = false;

  function toggleTheme() {
    isDark = !isDark;
    document.documentElement.classList.toggle("dark");
  }

  onMount(() => {
    // Check if dark mode is already enabled in the system
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      isDark = true;
      document.documentElement.classList.add("dark");
    }
    
    setTimeout(() => {
      isLoaded = true;
    }, 100);
  });
</script>

{#if isLoaded}
  <main in:fade={{ duration: 800 }} class:dark={isDark} class="overflow-hidden">
    <!-- Hero Section -->
    <section class="relative min-h-[60vh] lg:min-h-[70vh] bg-black overflow-hidden">
      <!-- Option 1: Campus library scene -->
      <div class="absolute inset-0 w-full h-full">
        <img
          src="/images/modern-studio.webp"
          alt="Modern therapy studio"
          class="absolute inset-0 w-full h-full object-cover object-center"
        />
        <div class="absolute inset-0 bg-gradient-to-b from-black/60 to-black/80"></div>
      </div>

      <div
        class="relative z-10 h-full flex flex-col items-center justify-center text-center px-4 py-12 lg:p-8"
      >
        <div
          class="max-w-4xl mx-auto space-y-6 pt-20"
          in:fly={{ y: 20, duration: 800 }}
        >
          <h1 class="text-white/90 text-4xl lg:text-5xl hero-text font-['SF_UI_Display_Light']">
            About Tikwah
          </h1>
          <p class="text-white/80 text-lg lg:text-xl max-w-2xl mx-auto">
            Our mission is to make therapy accessible, straightforward, and effective for everyone, Irrespective of age or gender.
          </p>
        </div>
      </div>

      <!-- Navigation -->
      <div class="absolute top-4 left-4 z-50">
        <a 
          href="/" 
          class="flex items-center space-x-2 text-white/90 hover:text-white transition-colors"
        >
          <span class="text-xl">تيكفا</span>
          <span class="text-white/70">Tikwah</span>
        </a>
      </div>

      <!-- Theme Toggle -->
      <button
        class="absolute top-4 right-4 z-50 p-2 rounded-lg bg-gray-100 dark:bg-[#0E0E0C] dark:border dark:border-gray-900 text-gray-900 dark:text-white shadow-lg"
        on:click={toggleTheme}
        in:fade={{ duration: 800, delay: 800 }}
      >
        {#if isDark}
          <img src="/icons/moon.svg" alt="Dark mode" class="w-5 h-5" />
        {:else}
          <img src="/icons/sun.svg" alt="Light mode" class="w-5 h-5" />
        {/if}
      </button>
    </section>

    <!-- Our Story Section -->
    <section class="py-16 lg:py-24 bg-white dark:bg-[#0E0E0C]">
      <div class="max-w-6xl mx-auto px-4 md:px-6 lg:px-8">
        <div
          class="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20 items-center"
          in:fly={{ y: 20, duration: 800, delay: 200 }}
        >
          <div class="space-y-6">
            <h2 class="text-3xl lg:text-4xl font-['SF_UI_Display_Medium'] text-gray-900 dark:text-white">
              Our Story
            </h2>
            <p class="text-gray-700 dark:text-gray-300 text-lg">
              Tikwah was founded with a simple belief: mental healthcare should be accessible, 
              approachable, and tailored to each individual's unique journey. 
            </p>
            <p class="text-gray-700 dark:text-gray-300">
              The name "Tikwah" (تيكفا) means "hope" in Hebrew, reflecting our commitment 
              to offering a beacon of hope and support for everyone seeking mental wellness.
            </p>
            <p class="text-gray-700 dark:text-gray-300">
              We've built our platform with care and attention to create a space where 
              anyone can connect with our qualified therapist without having to worry about their backgrounds, 
              privacy by connecting from the comfort of their home.
            </p>
          </div>
          <div class="relative h-80 lg:h-96">
            <div class="absolute inset-0 rounded-3xl overflow-hidden shadow-lg">
              <img
                src="/images/modern-studio.webp"
                alt="Comfortable therapy space"
                class="w-full h-full object-cover"
              />
            </div>
            <div class="absolute -bottom-6 -right-6 text-[100px] text-[#DBC594]/40 hidden md:block">
              桜
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Meet Our Therapist Section -->
    <section class="py-16 lg:py-24 bg-gray-50 dark:bg-black">
      <div class="max-w-6xl mx-auto px-4 md:px-6 lg:px-8">
        <div class="text-center mb-16" in:fly={{ y: 20, duration: 800, delay: 300 }}>
          <h2 class="text-3xl lg:text-4xl font-['SF_UI_Display_Medium'] text-gray-900 dark:text-white mb-4">
            Meet Our Lead Therapist
          </h2>
          <div class="w-24 h-1 bg-[#DBC594] mx-auto"></div>
        </div>

        <div
          class="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20 items-center"
          in:fly={{ y: 20, duration: 800, delay: 400 }}
        >
          <div class="lg:order-2 space-y-6">
            <h3 class="text-2xl lg:text-3xl font-['SF_UI_Display_Medium'] text-gray-900 dark:text-white">
             Ms. Henah
            </h3>
            <p class="text-[#DBC594] font-['SF_UI_Display_Medium']">
             Psychologist, 10+ Years Experience
            </p>
            <p class="text-gray-700 dark:text-gray-300">
              With over two decades of dedicated experience, Ms Henah has transformed 
              the lives of hundreds of individuals struggling with anxiety, depression, academic stress,
              and personal challenges.
            </p>
            <p class="text-gray-700 dark:text-gray-300">
              After working in various university counseling centers for 10 years, she recognized the need 
              for more personalized care for every age group. Her approach combines evidence-based techniques
              with genuine warmth and understanding - creating a unique therapeutic experience that people who contact her
              consistently describe as "life-changing."
            </p>
            <p class="text-gray-700 dark:text-gray-300 italic">
              "I believe everybody  deserves a safe space to be heard. Life brings unique 
              pressures, and I'm dedicated to helping everyone not just survive, but thrive during their
              lifetime."
            </p>
          </div>
          <div class="lg:order-1 relative mx-auto lg:mx-0 max-w-md lg:max-w-none w-full">
            <div class="rounded-3xl overflow-hidden shadow-xl">
              <img
                src="/images/HenahMiss.jpeg" 
                alt="Ms.Henah"
                class="w-full h-full object-cover aspect-[4/3]"
              />
            </div>
            <div class="absolute -bottom-4 -left-4 p-4 bg-white dark:bg-[#0E0E0C] rounded-xl shadow-lg hidden sm:block">
              <div class="flex flex-col items-center justify-center">
                <span class="text-sm text-gray-500 dark:text-gray-400">Specializes in</span>
                <span class="text-lg font-bold text-gray-900 dark:text-white">Counseling</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Our Approach -->
    <section class="py-16 lg:py-24 bg-white dark:bg-[#0E0E0C]">
      <div class="max-w-6xl mx-auto px-4 md:px-6 lg:px-8">
        <div class="text-center mb-12" in:fly={{ y: 20, duration: 800, delay: 500 }}>
          <h2 class="text-3xl lg:text-4xl font-['SF_UI_Display_Medium'] text-gray-900 dark:text-white">
           Ms. Henah
          </h2>
          <p class="mt-4 text-gray-600 dark:text-gray-400 max-w-2xl mx-auto">
            A holistic, sympathy-centered approach tailored to individual's life
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 lg:gap-12" in:fly={{ y: 20, duration: 800, delay: 600 }}>
          <div class="bg-gray-50 dark:bg-black/40 p-6 rounded-xl shadow-sm">
            <div class="h-12 w-12 rounded-full bg-[#DBC594]/20 flex items-center justify-center mb-4">
              <span class="text-2xl text-[#DBC594]">1</span>
            </div>
            <h3 class="text-xl font-['SF_UI_Display_Medium'] text-gray-900 dark:text-white mb-3">
             Holistic Well-Being
            </h3>
            <p class="text-gray-700 dark:text-gray-300">
             Support that considers emotional, mental, and lifestyle factors, helping individuals build balance, resilience, and self-understanding in everyday life.
            </p>
          </div>
          
          <div class="bg-gray-50 dark:bg-black/40 p-6 rounded-xl shadow-sm">
            <div class="h-12 w-12 rounded-full bg-[#DBC594]/20 flex items-center justify-center mb-4">
              <span class="text-2xl text-[#DBC594]">2</span>
            </div>
            <h3 class="text-xl font-['SF_UI_Display_Medium'] text-gray-900 dark:text-white mb-3">
              Practical Coping Tools
            </h3>
            <p class="text-gray-700 dark:text-gray-300">
              Therapy that goes beyond conversation—offering actionable strategies that can be applied to work, relationships, personal challenges, and long-term growth.
            </p>
          </div>
          
          <div class="bg-gray-50 dark:bg-black/40 p-6 rounded-xl shadow-sm">
            <div class="h-12 w-12 rounded-full bg-[#DBC594]/20 flex items-center justify-center mb-4">
              <span class="text-2xl text-[#DBC594]">3</span>
            </div>
            <h3 class="text-xl font-['SF_UI_Display_Medium'] text-gray-900 dark:text-white mb-3">
             Flexible & Inclusive Care
            </h3>
            <p class="text-gray-700 dark:text-gray-300">
              Sessions designed to respect diverse schedules, life stages, identities, and needs—creating a safe, welcoming space for everyone.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact -->
    <section class="py-16 lg:py-24 bg-gray-50 dark:bg-black text-center">
      <div class="max-w-4xl mx-auto px-4 md:px-6 lg:px-8" in:fly={{ y: 20, duration: 800, delay: 700 }}>
        <h2 class="text-3xl lg:text-4xl font-['SF_UI_Display_Medium'] text-gray-900 dark:text-white mb-8">
          Ready to Start Your Journey?
        </h2>
        <p class="text-gray-700 dark:text-gray-300 mb-10 max-w-2xl mx-auto">
          Take the first step toward clarity, emotional well-being, and personal growth. Support is available for individuals of all ages, backgrounds, and life paths.
        </p>
        <a href="/signup" 
          class="px-8 py-3 bg-[#DBC594] rounded-full text-sm transition-colors hover:bg-[#C4B084] hero-text text-[#1E2012] font-semibold inline-block"
        >
          Book a Session
        </a>
      </div>
    </section>

    <!-- Footer -->
    <footer class="py-8 bg-gray-900 dark:bg-[#060606] text-white">
      <div class="max-w-6xl mx-auto px-4 md:px-6 lg:px-8">
        <div class="flex flex-col md:flex-row justify-between items-center">
          <div class="mb-4 md:mb-0">
            <span class="text-xl mr-2">تيكفا</span>
            <span class="text-gray-400">Tikwah</span>
          </div>
          <div class="flex space-x-6 mb-4 md:mb-0">
            <a href="/" class="text-gray-400 hover:text-white transition-colors">Home</a>
            <a href="/aboutus" class="text-white underline">About Us</a>
            <a href="/signup" class="text-gray-400 hover:text-white transition-colors">Book Session</a>
          </div>
          <div class="text-sm text-gray-400">
            © {new Date().getFullYear()} Tikwah. All rights reserved.
          </div>
        </div>
      </div>
    </footer>
  </main>
{:else}
  <div class="min-h-screen w-full bg-black"></div>
{/if}

<style>
  :global(.dark) {
    color-scheme: dark;
  }

  .hero-text {
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
  }

  /* Fix for possible overflow issues */
  main {
    max-width: 100vw;
    position: relative;
  }

  /* Improve font rendering */
  * {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }

  /* Fix responsive image behavior */
  img {
    max-width: 100%;
    height: auto;
  }
</style>