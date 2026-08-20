<script lang="ts">
  import { onMount } from "svelte";
  import { fade, crossfade } from "svelte/transition";
  import type { FadeParams } from "svelte/transition";

  let state = {
    loading: true,
    progress: 0,
    progressComplete: false,
    contentLoaded: false,
    currentArtIndex: 0,
    previousArtIndex: 0,
    scrollY: 0,
    transitioning: false,
  };

  const [send, receive] = crossfade({
    duration: 800,
    fallback: (node, params) =>
      fade(node, {
        delay: params.delay,
        duration: typeof params.duration === "number" ? params.duration : 800,
      }),
  });

  const assets = {
    artworks: [
      { url: "/images/colloseum.webp", caption: "The Colosseum" },
      { url: "/images/modern-studio.webp", caption: "Modern Studio" },
      { url: "/images/ancient-ruins.webp", caption: "Ancient Ruins" },
      { url: "/images/classical-statue.webp", caption: "Classical Statue" },
    ],
    hero: "/images/amphitheatre.webp",
    lines: "/images/lines.webp",
    grid: "/images/grid1.webp",
  };

  // Reports a 0..1 fraction as each image settles, so the counter on screen
  // tracks real download progress instead of starting to move only once every
  // byte has arrived.
  const preloadImages = (onProgress: (fraction: number) => void) => {
    const urls = [
      ...assets.artworks.map((art) => art.url),
      assets.hero,
      assets.lines,
    ];

    let settled = 0;
    return Promise.all(
      urls.map(
        (url) =>
          new Promise<void>((resolve) => {
            const img = new Image();
            // An error has to settle the promise too. Resolving only on load
            // means one missing or stalled image hangs the screen forever.
            const settle = () => {
              settled += 1;
              onProgress(settled / urls.length);
              resolve();
            };
            img.onload = settle;
            img.onerror = settle;
            img.src = url;
          })
      )
    );
  };

  const transitionToNextImage = () => {
    if (!state.transitioning) {
      state.transitioning = true;
      state.previousArtIndex = state.currentArtIndex;
      state.currentArtIndex =
        (state.currentArtIndex + 1) % assets.artworks.length;
      setTimeout(() => {
        state.transitioning = false;
      }, 600);
    }
  };

  // Long enough that the intro does not flash past on a fast connection.
  const MIN_VISIBLE_MS = 600;
  // Hard ceiling: a slow or dead asset must never hold the page hostage.
  const MAX_VISIBLE_MS = 6000;

  onMount(() => {
    const startedAt = Date.now();
    let revealed = false;

    const reveal = () => {
      if (revealed) return;
      revealed = true;
      state.progress = 100;
      state.progressComplete = true;
      state.loading = false;
      setTimeout(() => (state.contentLoaded = true), 200);
    };

    const bailout = setTimeout(reveal, MAX_VISIBLE_MS);

    preloadImages((fraction) => {
      state.progress = Math.max(state.progress, Math.round(fraction * 100));
    }).then(() => {
      clearTimeout(bailout);
      setTimeout(reveal, Math.max(0, MIN_VISIBLE_MS - (Date.now() - startedAt)));
    });

    const artInterval = setInterval(() => {
      if (state.loading) {
        transitionToNextImage();
      }
    }, 900);

    const handleScroll = () => {
      state.scrollY = window.scrollY;
    };

    window.addEventListener("scroll", handleScroll);

    // Registered synchronously, so unmounting mid-preload still tears down.
    return () => {
      clearTimeout(bailout);
      clearInterval(artInterval);
      window.removeEventListener("scroll", handleScroll);
    };
  });
</script>


{#if state.loading}
  <div class="fixed inset-0 bg-white z-50 flex items-center justify-center">
    <div class="w-full max-w-4xl aspect-video relative overflow-hidden">
      {#key state.currentArtIndex}
        <div class="absolute inset-0">
          <img
            src={assets.artworks[state.currentArtIndex].url}
            alt={assets.artworks[state.currentArtIndex].caption}
            class="w-full h-full object-cover"
            in:receive={{ key: state.currentArtIndex }}
            out:send={{ key: state.previousArtIndex }}
          />
        </div>
      {/key}
      <div class="absolute inset-0 bg-white/50"></div>

      <div class="absolute inset-0 flex flex-col items-center justify-center">
        <div
          class="text-[#9c7c35] text-8xl tracking-widest mb-4 font-bold"
          in:fade={{ duration: 400 }}
          out:fade={{ duration: 400 }}
        >
          {state.progress}
        </div>

        <div class="w-64 h-px text-[#DBC594]/20 relative">
          <div
            class="absolute top-0 left-0 h-full text-[#DBC594] transition-all duration-200"
            style="width: {state.progress}%"
          ></div>
        </div>
      </div>
    </div>
  </div>
{/if}
{#if state.contentLoaded}
  <main in:fade={{ duration: 1500 }}>
    <!-- Hero Section -->
    <section class="relative min-h-screen bg-black overflow-hidden">
      <div
        class="absolute inset-0 w-full h-full"
        style="transform: translateY({state.scrollY * 0.5}px)"
      >
        <img
          src={assets.hero}
          alt="Ancient amphitheater"
          class="absolute inset-0 w-full h-[120%] object-cover"
        />
        <div
          class="absolute inset-0 bg-gradient-to-b from-black/40 to-black/60"
        ></div>
      </div>

      <!-- Grid Background -->
      <div
        class="absolute inset-0 z-[1] flex items-center justify-center mt-20"
      >
        <img
          src={assets.grid}
          alt=""
          class="md:w-1/2 w-screen opacity-35 object-cover md:object-contain md:rotate-0 rotate-90"
        />
      </div>

      <nav class="relative z-10 p-6">
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <span class="text-white text-2xl">تيكفا</span>
            <span class="text-white/60 ml-2">Tikwah</span>
          </div>
          <div class="flex space-x-4">
            <a 
              href="/aboutus" 
              class="px-4 py-2 rounded-full text-white hover:bg-white/10 transition-colors"
            >
              About Us
            </a>
          </div>
        </div>
      </nav>

      <div
        class="relative z-10 h-[calc(100vh-80px)] flex flex-col items-center justify-center text-center"
      >
        <div class="max-w-2xl mx-auto space-y-6">
          <h1 class="text-white/80 text-2xl hero-text">
            Sessions that works for you,<br /> not against you
          </h1>
          <div
            class="flex justify-between items-center w-full max-w-xl mx-auto mb-16 space-x-6"
          >
            <span class="text-white/80 w-36 md:w-56 text-2xl hero-text"
              >Counselling made simple</span
            >
            <div class="text-[50px] md:text-[80px] text-white m-0 font-bold">
              桜
            </div>
            <span class="text-white/80 w-36 md:w-56 text-2xl hero-text"
              >Mental Health, accessible for everyone..</span
            >
          </div>
          <a href="/aboutus">
            <button
              class="px-8 py-3 bg-[#DBC594] rounded-full text-sm transition-colors hover:bg-[#C4B084] hero-text text-[#1E2012] font-semibold"
            >
              Get Started
            </button>
          </a>
          
        </div>
        <div
          class="absolute bottom-8 right-8 text-[#DBC594]/60 opacity-40 text-sm"
        >
          Photo by Wendy Wei from Pexels
        </div>
      </div>
    </section>

    <!-- Mission Statement Section -->
    <section class="bg-white px-4 md:px-8 py-24">
      <div
        class="flex flex-col md:flex-row items-center justify-between max-w-7xl mx-auto"
      >
        <div
          class="max-w-xl space-y-8 mx-4 md:ml-20 text-center md:text-left mb-12 md:mb-0"
        >
          {#each ["Finding help shouldn't be complicated", "A journey of self-discovery and healing", "A space for growth and positive change"] as text}
            <div class="border-b border-gray-300 pb-4">
              <p class="text-2xl text-gray-900">{text}</p>
            </div>
          {/each}
        </div>

        <div
          class="flex items-center justify-center relative h-96 mx-4 md:mr-20"
        >
          <img
            src={assets.lines}
            alt="Decorative element"
            class="w-auto h-full object-cover opacity-50 absolute"
          />
          <span
            class="text-6xl md:text-8xl font-bold text-black whitespace-nowrap bg-white/80 px-4 relative"
          >
            Tikwah.
          </span>
        </div>
      </div>
    </section>

    <!-- Colosseum Image Section -->
    <div class="relative w-full">
      <img
        src={assets.artworks[0].url}
        alt="Colosseum"
        class="w-full h-[50vh] object-cover"
      />
      <div class="absolute bottom-4 left-4 text-white/60 opacity-90 text-xs">
        Photo by Andrei Tanase from Pexels
      </div>
    </div>
  </main>
{/if}

<style>
  @font-face {
    font-family: "SH AD Grotesk";
    src: url("/fonts/Sh Ad Grotesk Regular.woff") format("woff");
    font-weight: normal;
    font-style: normal;
    font-display: swap;
  }

  @font-face {
    font-family: "SH AD Grotesk Medium";
    src: url("/fonts/Sh Ad Grotesk Medium Regular.woff") format("woff");
    font-weight: normal;
    font-style: normal;
    font-display: swap;
  }

  :global(body) {
    margin: 0;
    font-family:
      "SH AD Grotesk",
      system-ui,
      -apple-system,
      sans-serif;
    background: #000;
    overflow-x: hidden;
  }

  /* Hide scrollbar for all browsers */
  :global(html) {
    scroll-behavior: smooth;
    scrollbar-width: none;
    -ms-overflow-style: none;
  }

  :global(html::-webkit-scrollbar) {
    display: none;
  }

  :global(*) {
    box-sizing: border-box;
  }

  /* Consistent text styles */
  :global(h1),
  :global(h2),
  :global(p),
  :global(span) {
    font-family:
      "SH AD Grotesk",
      system-ui,
      -apple-system,
      sans-serif;
  }

  /* Hero section specific text styles */
  :global(.hero-text) {
    font-family:
      "SH AD Grotesk",
      system-ui,
      -apple-system,
      sans-serif !important;
  }

  /* Get Started button specific style */
  :global(button) {
    font-family:
      "SH AD Grotesk",
      system-ui,
      -apple-system,
      sans-serif !important;
  }
</style>
